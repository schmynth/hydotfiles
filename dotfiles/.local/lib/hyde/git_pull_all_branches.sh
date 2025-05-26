#!/bin/bash
git fetch --all
for branch in $(git branch -r | grep -v '\->'); do
    git checkout ${branch#origin/}
    git pull
done
