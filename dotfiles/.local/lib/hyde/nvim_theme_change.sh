#!/bin/bash

THEME="$1"

if [ -z "$THEME" ]; then
  echo "Usage: $0 <theme-name>"
  exit 0
fi

NVIM_SOCKET="/tmp/nvimsocket"

nvr --server-name "$NVIM_SOCKET" --remote-send "<ESC>:colorscheme $THEME<CR>"
nvr --server-name "$NVIM_SOCKET" --remote-send "<ESC>:TransparentEnable<CR>"

nvr --servername "$NVIM_SOCKET" --remote-send \
":lua pcall(function() vim.cmd('colorscheme $THEME'); vim.notify('🌈 Theme set to $THEME', vim.log.levels.INFO) end)<CR>"
