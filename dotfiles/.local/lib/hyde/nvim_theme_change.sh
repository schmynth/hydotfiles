#!/bin/bash

THEME="$1"

if [ -z "$THEME" ]; then
  echo "Usage: $0 <theme-name>"
  exit 0
fi

NVIM_SOCKET="/tmp/nvim"

nvr --server-name "$NVIM_SOCKET" --remote-send "<ESC>:colorscheme $THEME<CR>"
nvr --server-name "$NVIM_SOCKET" --remote-send "<ESC>:TransparentEnable<CR>"
