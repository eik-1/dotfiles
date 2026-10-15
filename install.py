#!/usr/bin/env python3
"""Link the AI and Zed dotfiles, preserving existing files outside the repo."""

import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import shutil


ROOT = Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dry-run", action="store_true", help="Show changes without writing files")
    parser.add_argument("--home", type=Path, default=Path.home(), help="Destination home directory")
    args = parser.parse_args()
    home = args.home.expanduser().absolute()
    entries = json.loads((ROOT / "links.json").read_text())
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S.%fZ")
    backup = home / ".local/state/dotfiles-backups" / timestamp
    plans = []

    # Check every source and destination before making any changes.
    for entry in entries:
        source = ROOT / entry["source"]
        target = home / entry["target"]
        source.resolve().relative_to(ROOT)
        target.relative_to(home)
        if not source.exists():
            parser.error(f"Missing source: {source}")
        if target.is_symlink() and target.resolve() == source.resolve():
            print(f"OK {target}")
            continue
        plans.append((source, target))

    for source, target in plans:
        if os.path.lexists(target):
            saved = backup / target.relative_to(home)
            print(f"BACKUP {target} -> {saved}")
            if not args.dry_run:
                backup.mkdir(parents=True, exist_ok=True, mode=0o700)
                saved.parent.mkdir(parents=True, exist_ok=True)
                shutil.move(str(target), str(saved))
        print(f"LINK {target} -> {source}")
        if not args.dry_run:
            target.parent.mkdir(parents=True, exist_ok=True)
            target.symlink_to(source, target_is_directory=source.is_dir())

    if plans and not args.dry_run:
        print("Links installed. Restart the affected tools to reload their configuration.")
    elif not plans:
        print("All links are already installed.")


if __name__ == "__main__":
    main()
