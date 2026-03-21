#!/usr/bin/env bash

SEQ_FILE="$HOME/.local/state/quickshell/user/generated/terminal/sequences.txt"
KITTY_THEME="$HOME/.config/kitty/theme.conf"

if [[ ! -f "$SEQ_FILE" ]]; then
  echo "Error: sequences.txt not found at $SEQ_FILE"
  exit 1
fi

# Clear old theme file
>"$KITTY_THEME"

# Parse basic 16 colors (OSC 4)
grep -oP '\033\]4;(\d+);#([0-9a-fA-F]{6})\007' "$SEQ_FILE" | while read -r line; do
  num=$(echo "$line" | sed -E 's/.*4;([0-9]+);.*/\1/')
  color=$(echo "$line" | sed -E 's/.*;#([0-9a-fA-F]{6}).*/\1/')
  echo "color$$   num #   $${color^^}" >>"$KITTY_THEME"
done

# Foreground (OSC 10), Background (OSC 11), Cursor (OSC 12) — fallback defaults if missing
fg=$(grep -oP '\033\]10;#([0-9a-fA-F]{6})\007' "$SEQ_FILE" | sed -E 's/.*;#([0-9a-fA-F]{6}).*/\1/' || echo "cdd6f4")
bg=$(grep -oP '\033\]11;#([0-9a-fA-F]{6})\007' "$SEQ_FILE" | sed -E 's/.*;#([0-9a-fA-F]{6}).*/\1/' || echo "1e1e2e")
cursor=$(grep -oP '\033\]12;#([0-9a-fA-F]{6})\007' "$SEQ_FILE" | sed -E 's/.*;#([0-9a-fA-F]{6}).*/\1/' || echo "f38ba8")

echo "foreground #${fg^^}" >>"$KITTY_THEME"
echo "background #${bg^^}" >>"$KITTY_THEME"
echo "cursor #${cursor^^}" >>"$KITTY_THEME"

echo "Generated Kitty theme at $KITTY_THEME"
