#!/bin/bash

scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

# find full path of script:
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log_section="VS Code Extensions"

while read -r line; do
  print_log -info "Info" -b " [install] :: " "${line}"
  code --install-extension ${line} || print_log -err "installation of ${line} failed"
done < ${scrDir}/lists/code-extensions.lst
