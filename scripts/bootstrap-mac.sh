#!/bin/bash
# Run locally on a destination Mac. Never run the complete setup as root.
set -euo pipefail

usage() {
    cat <<'HELP'
Usage: bash bootstrap-mac.sh --apply

Install Homebrew, chezmoi, the declared apps/tools/extensions, and personal
settings on a destination Mac. Existing managed configuration is backed up.
Administrator and application sign-in prompts must be completed locally.

Restore ~/.config/chezmoi/key.txt (mode 600) before applying encrypted settings,
or set CHEZMOI_AGE_IDENTITY_FILE to a securely restored identity file.
The identity is never downloaded from Git. Rerun this command after restoring it.

Existing ~/.dotfiles checkouts are used as-is: no automatic pull or reset.
No packages are uninstalled, no private SSH keys are cloned, and no accounts
are signed in automatically. Do not apply this on the authoritative source Mac.
HELP
}

case "${1:-}" in
    --help|-h|"") usage; exit 0 ;;
    --apply) [ "$#" -eq 1 ] || { usage; exit 2; } ;;
    *) usage >&2; exit 2 ;;
esac
[ "$(uname -s)" = Darwin ] || { echo 'This setup requires macOS.' >&2; exit 1; }
[ "$(id -u)" -ne 0 ] || { echo 'Run as your normal Mac user, without sudo.' >&2; exit 1; }

umask 077
state="$HOME/.local/state/mac-bootstrap/$(date -u +%Y%m%dT%H%M%SZ)-$$"
mkdir -p "$state"
targets=(.zprofile .zshrc .config .ssh/config
    'Library/Application Support/Code/User/settings.json'
    'Library/Application Support/Code/User/keybindings.json'
    'Library/Application Support/Code/User/tasks.json'
    'Library/Application Support/Code/User/snippets'
    'Library/Application Support/Code/User/mcp.json'
    'Library/Application Support/Code/User/chatLanguageModels.json')
existing=()
for target in "${targets[@]}"; do
    if [ -e "$HOME/$target" ] || [ -L "$HOME/$target" ]; then
        existing+=("$target")
    fi
done
if [ "${#existing[@]}" -gt 0 ]; then
    tar -czf "$state/before.tar.gz" -C "$HOME" "${existing[@]}"
fi
printf 'Private recovery directory: %s\n' "$state"

if [ -x /opt/homebrew/bin/brew ]; then
    brewbin=/opt/homebrew/bin/brew
elif [ -x /usr/local/bin/brew ]; then
    brewbin=/usr/local/bin/brew
else
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh \
        -o "$state/homebrew-install.sh"
    /bin/bash "$state/homebrew-install.sh"
    if [ -x /opt/homebrew/bin/brew ]; then
        brewbin=/opt/homebrew/bin/brew
    else
        brewbin=/usr/local/bin/brew
    fi
fi
eval "$("$brewbin" shellenv)"
brew install chezmoi age

source_dir="$HOME/.dotfiles"
if [ -e "$source_dir" ]; then
    [ -d "$source_dir/.git" ] || { echo '~/.dotfiles is not a Git checkout.' >&2; exit 1; }
    remote=$(git -C "$source_dir" remote get-url origin)
    case "$remote" in
        https://github.com/mturilli/dotfiles|https://github.com/mturilli/dotfiles.git|git@github.com:mturilli/dotfiles.git) ;;
        *) echo 'Existing ~/.dotfiles has an unexpected origin; inspect it before continuing.' >&2; exit 1 ;;
    esac
else
    chezmoi init --source "$source_dir" https://github.com/mturilli/dotfiles.git
fi

mkdir -p "$HOME/.config/chezmoi"
chmod 700 "$HOME/.config/chezmoi"
identity="$HOME/.config/chezmoi/key.txt"
if [ ! -s "$identity" ] && [ -n "${CHEZMOI_AGE_IDENTITY_FILE:-}" ]; then
    install -m 600 "$CHEZMOI_AGE_IDENTITY_FILE" "$identity"
fi
if [ ! -s "$identity" ]; then
    echo 'The private age identity is missing. Securely restore ~/.config/chezmoi/key.txt,' >&2
    echo 'set its permissions to 600, then rerun this same command.' >&2
    exit 2
fi
chmod 600 "$identity"
chezmoi execute-template --file "$source_dir/dot_config/chezmoi/chezmoi.toml.tmpl" \
    > "$state/chezmoi.toml"
install -m 600 "$state/chezmoi.toml" "$HOME/.config/chezmoi/chezmoi.toml"

# Apply files first. This also ensures Homebrew can be reconciled on every rerun,
# even when chezmoi has already recorded a successful package-script hash.
chezmoi apply --exclude scripts
chezmoi apply
brew bundle --no-upgrade --file="$HOME/.config/homebrew/Brewfile"
chezmoi verify
brew bundle check --no-upgrade --file="$HOME/.config/homebrew/Brewfile"
/bin/zsh -lic 'command -v brew; command -v chezmoi; command -v code; command -v codex; command -v claude'
printf 'Configuration and package checks passed.\n'
printf 'Complete LastPass, ChatGPT/Codex and Claude sign-ins, Safari extension permissions,\n'
printf 'and provision this Mac\047s SSH keys separately. Recovery: %s\n' "$state"
