#!/bin/bash

echo "Don't use this yet"

print_help() {
  cat << EOF
usage: git_utils.sh [options] [url] [target directory]

url is only needed when cloning or setting remote url.
target directory is only needed when repo is not to be cloned in cwd.

options:
--clone-all-branches: clones all branches of given github repository into seperate folders
                      in the same parent directory.
--pull-all-branches: pulls all branches
--push-all-branches: pushes all branches. IMPORTANT: provide a commit message as argument!
                      This will also \`git add .\`, so remove unnecessary files first!
--set-remote: sets remote url to given url.
EOF
}

cwd=$(pwd)

# $2 is url
# $3 is target directory

case $1 in
  --clone-all-branches)
    REPO_URL="$2"
    BASE_DIR="${3:-$cwd}"

    mkdir -p "$BASE_DIR"
    cd "$BASE_DIR" || exit 1

    # Get all remote branches
    git ls-remote --heads "$REPO_URL" | awk '{print $2}' | sed 's#refs/heads/##' | while read -r branch; do
        echo "Cloning branch: $branch"
        git clone --branch "$branch" --single-branch "$REPO_URL" "$branch"
    done
    ;;
  --pull-all-branches)
    BASE_DIR="${2:-$cwd}"
    cd $BASE_DIR
    for dir in */; do
      cd $dir || echo "ERROR: no directory found"
      git pull || echo "ERROR: pull failed."
      cd ..
    done
    ;;
  --push-all-branches)
    BASE_DIR="${2:-$cwd}"
    cd $BASE_DIR
    for dir in */; do
      cd $dir
      git add .
      git commit -m "$3" || echo "ERROR: commit failed"
      git push || echo "ERROR: push failed"
      cd ..
    done
    ;;
  --set-remote)
    BASE_DIR="${3:-$cwd}"
    cd $BASE_DIR
    for dir in */; do
      cd $dir
      git remote set-url origin $2
      cd ..
    done
    ;;
  *)
    echo "wrong option"
    print_help
    ;;
esac

