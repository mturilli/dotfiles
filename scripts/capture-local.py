#!/usr/bin/env python3
"""Capture authoritative local settings into source; never apply, pull or push."""
from pathlib import Path
import subprocess


def run(*args):
    subprocess.run(args, check=True)


def main():
    home = Path.home()
    repo = Path(__file__).resolve().parents[1]
    configured = Path(subprocess.check_output(["chezmoi", "source-path"], text=True).strip())
    if configured.resolve() != repo:
        raise SystemExit("This checkout is not the configured chezmoi source directory")
    targets = [home / name for name in [
        ".zshrc", ".zprofile", ".config/git/config", ".config/git/ignore",
        ".ssh/config", ".config/uv/uv.toml", ".config/homebrew/Brewfile",
    ]]
    targets += sorted((home / ".config/zsh").glob("*.zsh"))
    missing = [str(p) for p in targets if not p.is_file()]
    if missing:
        raise SystemExit("Expected local configuration is missing: " + ", ".join(missing))
    originals = {p: p.read_bytes() for p in targets}
    templated = [home / ".config/git/config", home / ".ssh/config"]
    plain = [p for p in targets if p not in templated]
    run("chezmoi", "add", "--secrets", "error", *map(str, plain))
    run("chezmoi", "add", "--secrets", "error", "--template", *map(str, templated))
    for target, name in [
        (home / ".config/git/config", "dot_config/git/config"),
        (home / ".ssh/config", "private_dot_ssh/private_config"),
    ]:
        # Escape literal Go-template delimiters before inserting our one variable.
        text = originals[target].decode().replace("{{", '{{ "{{" }}')
        text = text.replace(str(home), "{{ .chezmoi.homeDir }}")
        source = repo / (name + ".tmpl")
        source.write_text(text)
        plain = repo / name
        if plain.exists():
            plain.unlink()
    for p, before in originals.items():
        if p.read_bytes() != before:
            raise SystemExit("A live file changed during capture; review before committing")
    run("chezmoi", "verify", *map(str, targets))
    print("Captured and verified local settings. Review the source diff before committing.")
    print("No live files were applied, and nothing was pulled, committed or pushed.")


if __name__ == "__main__":
    main()
