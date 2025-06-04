#!/usr/bin/env bash

# original lockscreen script of hyde
# replaced by lock_with_layout.sh
# for ensuring german kb layout is used

scrDir="$(dirname "$(realpath "$0")")"
# shellcheck source=$HOME/.local/lib/hyde/globalcontrol.sh
# shellcheck disable=SC1091
source "${scrDir}/globalcontrol.sh"
HYDE_RUNTIME_DIR="${HYDE_RUNTIME_DIR:-$XDG_RUNTIME_DIR/hyde}"
# shellcheck disable=SC1091
source "${HYDE_RUNTIME_DIR}/environment"

"${LOCKSCREEN}" "${@}"
