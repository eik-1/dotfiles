# Dotfiles

Personal shell, desktop, terminal, editor, and AI tool configuration.

## AI tools and Zed

```text
ai/
  skills/           Shared personal skills and their supporting files
  claude/           Settings, rules, and custom agents
  herdr/            Settings and a portable plugin list
zed/
  settings.json     Zed user settings, including AI and editor preferences
```

The shared skills are `context7-mcp`, `find-skills`, `frontend-design`, `grill-me`,
`teach`, and `unslop`. Their actual files live in `ai/skills/`; Claude has a
relative link to that directory. Codex discovers the same
directory through `~/.agents/skills`.

Bundled skills, plugin downloads, application
binaries, credentials, caches, and session history stay outside this repo.
Install the tools and their bundled plugins separately.

## Restore the links

Clone this repo, then preview and install the AI and Zed links:

```sh
python3 install.py --dry-run
python3 install.py
```

`links.json` lists every source and destination. Existing files or directories
are moved to `~/.local/state/dotfiles-backups/<timestamp>/` before replacement.
Running the installer again leaves correct links alone. It does not install
packages or change your other shell and desktop links.

Restart the affected applications after installing. Review machine-specific SSH
hostnames and project paths in Zed settings when restoring on a different machine.

## Herdr plugins

`ai/herdr/plugins.json` records plugin sources, pinned revisions, and enabled
state without machine-specific installation paths. It is an inventory, not a
replacement for Herdr's generated `~/.config/herdr/plugins.json` registry.

To restore the currently recorded Reviewr plugin:

```sh
herdr plugin install persiyanov/herdr-reviewr --ref 4c090225af706bf3aaa24b39fea890a72994f40f
```

See [Herdr plugin commands](https://github.com/herdrdev/herdr/blob/master/docs/versions/0.9.2/website/src/content/docs/cli-reference.mdx).

Claude also had these installed plugins when the configs were collected:
`frontend-design`, `security-guidance`, and `playwright`, from
`anthropics/claude-plugins-official`. Reinstall them through Claude as needed;
the generated installation registry and project-specific paths are not tracked.
