# Dotfiles

Personal macOS CLI configuration managed with [chezmoi](https://www.chezmoi.io/).
The primary Mac's live configuration is authoritative. This public repository is
an occasionally published snapshot for rebuilding another machine, including the
M2 Air. It is not a source of automatic updates for the primary Mac.

## Capture changes on the primary Mac

```sh
python3 ~/.dotfiles/scripts/capture-local.py
cd ~/.dotfiles
git status --short
git diff
# Review the exact files, then stage, commit and push them explicitly.
```

The helper captures the live shell, Git, SSH, UV and Brewfile settings into
chezmoi source and verifies that they render back to the original live files.
It never runs apply/update, pulls, installs packages, commits or pushes. Secret
scanning is enabled, but still review before publishing. Git and SSH home paths
are templates; identity settings and connection rules retain their local values.
The helper maintains these templates without chezmoi's broad auto-templating.
For other applications, review and capture their specific files with `chezmoi add`.
The Brewfile is a package selection, not a snapshot of package versions or data.

Do not run `chezmoi apply` or `chezmoi update` on this primary Mac to refresh its
configuration. Capture from the live files instead. Do not blindly stage all
files: credentials and machine-specific runtime state must stay out of Git.

## Set up the M2 Air

First back up any existing M2 configuration and check its macOS compatibility
with the selected packages. Both Macs are Apple Silicon. Install Apple's command
line tools and Homebrew from their official instructions, then:

```sh
brew install chezmoi age
mkdir -p ~/.config/chezmoi
chmod 700 ~/.config/chezmoi
```

Securely restore the separate chezmoi age identity to
`~/.config/chezmoi/key.txt`, mode 600. Never put that identity in this repository.
It is needed to decrypt the already-managed GitHub configuration. SSH private keys
and macOS Keychain items are not supplied by this repository. Securely provision
required SSH identities, or create M2-specific keys and register them with the
relevant hosts/GitHub. The Git signing setting expects a public-key file at its
configured path; authentication and signing registrations are separate.

Initialize source without applying, then install the portable initial chezmoi
configuration. These commands are for the destination M2, not the primary Mac:

```sh
chezmoi init --source "$HOME/.dotfiles" https://github.com/mturilli/dotfiles.git
chezmoi execute-template --file "$HOME/.dotfiles/dot_config/chezmoi/chezmoi.toml.tmpl" > "$HOME/.config/chezmoi/chezmoi.toml"
chmod 600 "$HOME/.config/chezmoi/chezmoi.toml"
chezmoi diff
```

Review privately: the diff can include decrypted configuration. After review,
`chezmoi apply` installs the configuration and runs the one-time Homebrew bundle
bootstrap. Then run `chezmoi verify` and `brew bundle check --no-upgrade
--file="$HOME/.config/homebrew/Brewfile"`, and verify Git signing, SSH and a fresh
login shell. This M2 procedure is documented, not yet tested on the actual M2.

UV prefers its own managed Python builds and downloads missing versions on use.
Project environments/dependencies are rebuilt from each project's configuration;
they are not copied by chezmoi. The primary Mac retains pyenv because an existing
project environment references Python 3.13.7; installing pyenv via Brewfile does
not automatically reproduce its interpreter installations or project environments.

VM disks, Colima images, working repositories, app databases, SSH keys and other
private state need their own backup/restore or rebuild. No scheduled pull or
automatic deployment is configured by this repository.
