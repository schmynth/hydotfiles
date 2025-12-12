#!/bin/bash

THEME="$1"

if [ -z "$THEME" ]; then
  echo "Usage: $0 <theme-name>"
  exit 0
fi

echo "$THEME" >~/.config/nvim/.current_theme

# Match all sockets like: /tmp/nvim_socketXXXX.sock
SOCKETS=$(find /tmp -maxdepth 1 -type s -name "nvim_socket*")

if [ -z "$SOCKETS" ]; then
  echo "No nvim sockets found matching /tmp/nvim_socket*"
  exit 0
fi

for SOCKET in $SOCKETS; do
  echo "→ Updating theme on $SOCKET"

  # Basic colorscheme command
  nvr --servername "$SOCKET" \
    --remote-send "<ESC>:colorscheme $THEME<CR>"

  # Enable Transparent if you want this for all instances
  nvr --servername "$SOCKET" \
    --remote-send "<ESC>:TransparentEnable<CR>"

  # Lua wrapper with notify
  nvr --servername "$SOCKET" --remote-send \
    ":lua pcall(function() vim.cmd('colorscheme $THEME'); vim.notify('🌈 Theme set to $THEME', vim.log.levels.INFO) end)<CR>"
done
