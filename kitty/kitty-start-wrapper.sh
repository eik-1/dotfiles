#!/usr/bin/env bash

SEQ_FILE="$HOME/.local/state/quickshell/user/generated/terminal/sequences.txt"

if [[ -f "$SEQ_FILE" ]]; then
  cat "$SEQ_FILE" # Kitty reads and applies these escape sequences
else
  # Fallback colors (adjust hex values to match your default theme if needed)
  echo -e "\033]11;#1e1e2e\007" # background
  echo -e "\033]10;#cdd6f4\007" # foreground
  echo -e "\033]12;#f38ba8\007" # cursor
fi

# Launch your real shell (bash)
exec bash "$@"
