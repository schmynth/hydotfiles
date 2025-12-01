#!/bin/bash

# Create a unique socket for this Neovim instance
# $$ is a special variable containing the PID of this script
# $RANDOM is a random number
SOCKET="/tmp/nvim_socket-$$-$RANDOM"

# # Export so Neovim listens on it
# export NVIM_LISTEN_ADDRESS="$SOCKET"
#
# # Optional: print socket for external scripts/tools
# echo "[nvim wrapper] Listening on: $SOCKET"

# Launch Neovim with all passed arguments
nvim --listen $SOCKET "$@"

# Clean up after exit
[ -e "$SOCKET" ] && rm -f "$SOCKET"
