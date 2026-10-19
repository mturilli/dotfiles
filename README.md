# Dotfiles

Personal macOS CLI configuration managed with [chezmoi](https://www.chezmoi.io/).
The primary Mac's live configuration is authoritative. This public repository is
an occasionally published snapshot for rebuilding another machine, including the
M2 Air. It is not a source of automatic updates for the primary Mac. The Brewfile is an
explicit destination package selection, including apps requested for the M2.

## Capture changes on the primary Mac

```sh
python3 ~/.dotfiles/scripts/capture-local.py
cd ~/.dotfiles
git status --short
git diff
# Review the exact files, then stage, commit and push them explicitly.
```

The helper captures the live shell, Git, SSH, UV and Ghostty settings into
chezmoi source and verifies that they render back to the original live files.
It never runs apply/update, pulls, installs packages, commits or pushes. Secret
scanning is enabled, but still review before publishing. Git and SSH home paths
are templates; identity settings and connection rules retain their local values.
The helper maintains these templates without chezmoi's broad auto-templating.
VS Code settings, MCP definitions and model preferences are captured with age
encryption. Keybindings, tasks and snippets are included when present. Never
commit their plaintext contents. Maintain the destination Brewfile explicitly;
the capture helper does not overwrite it from the source Mac. For other
applications, review and capture their specific files with `chezmoi add`.
The Brewfile is a package selection, not a snapshot of package versions or data.

Do not run `chezmoi apply` or `chezmoi update` on this primary Mac to refresh its
configuration. Capture from the live files instead. Do not blindly stage all
files: credentials and machine-specific runtime state must stay out of Git.

## Set up a destination Mac

After completing macOS setup, securely restore the separate age identity to
`~/.config/chezmoi/key.txt` with mode 600. Never put that identity in Git.
Then run this **on the destination Mac**, from a local Terminal:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/mturilli/dotfiles/main/scripts/bootstrap-mac.sh) --apply
```

The bootstrap installs Apple's command-line tools through Homebrew's official
installer when needed, Homebrew, chezmoi and age; backs up existing managed
configuration; initializes this source checkout; applies the settings; installs
the declared tools, apps and VS Code extensions; and verifies the result.
The package selection includes Ghostty, VS Code, LastPass, ChatGPT (including
Codex), Claude desktop and Claude Code CLI. Codex CLI uses OpenAI's official
standalone installer because the Homebrew cask's binary stalled on this M2,
while the same-version official standalone distribution passed. Matching Fira Code fonts
are installed when they are not already present. Existing matching manually
installed font files are preserved. Package versions are not pinned.

Run this locally because Homebrew and package installers such as Zoom can need
an administrator password. Missing age identity stops setup with an explanation;
restore it securely and rerun. Passwords and identity contents are never printed.
Private recovery archives are stored in `~/.local/state/mac-bootstrap/`.

On an existing destination checkout, rerun:

```sh
bash ~/.dotfiles/scripts/bootstrap-mac.sh --apply
```

Existing source is used as-is. There is no automatic pull, reset, scheduled sync,
package removal, or upgrade of already-installed packages. To adopt a newer
recipe on a destination, inspect and fast-forward its checkout deliberately
before rerunning. Do not apply/update this repository on the primary source Mac.

The package hook runs after files are installed and tracks the Brewfile checksum,
so future declared-package changes trigger reconciliation. The bootstrap also
reconciles packages on every explicit rerun, repairing missing packages even if
the recipe itself has not changed. No Ansible installation is needed for this
apps-and-dotfiles scope; Ansible can be added later for broader system policies.

### Private state and manual completion

Encrypted GitHub and VS Code configuration requires the separate age identity.
Application sign-ins, LastPass vault unlock and Safari extension permissions
remain local steps. Neither a logged-in password vault nor macOS Keychain items
are copied. Homebrew installs the vendor's LastPass Mac app; its package version
can differ from the Chrome/Firefox extension version shown on the vendor site.

SSH private keys are not supplied by this repository. Provision destination-specific
SSH identities and register them with the relevant hosts/GitHub. The Git signing
setting references a public-key file at its configured path; authentication and
signing registrations are separate. Git's global automatic commit signing is
currently disabled, so copying configuration alone does not establish signing.

The current M2 setup required importing the already-installed Rewrap 17.8.0
copy from the primary Mac because its marketplace package failed signature
verification. That local VSIX, including the vendor license, is stored with age
encryption. The package hook installs it before reconciling the extension list
on a clean destination. Global signature checks remain enabled. LastPass
currently needs Rosetta on Apple Silicon; the hook installs it when missing,
with Apple's interactive license prompt on a fresh machine.

UV prefers its own managed Python builds and downloads missing versions on use.
Project environments/dependencies are rebuilt from each project's configuration;
they are not copied by chezmoi. The primary Mac retains pyenv because an existing
project environment references Python 3.13.7; installing pyenv via Brewfile does
not automatically reproduce its interpreter installations or project environments.

VM disks, Colima images, working repositories, app databases, SSH keys and other
private state need their own backup/restore or rebuild. No scheduled pull or
automatic deployment is configured by this repository.
