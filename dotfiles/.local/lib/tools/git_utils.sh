#!/bin/bash

for dir in */; do
  cd $dir
  echo $dir
  git remote set-url origin https://[token]@github.com/[username]/[repo-name]
  cd ..
done
