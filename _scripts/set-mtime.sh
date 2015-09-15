#!/usr/bin/env bash
# Thanks to http://disq.us/8oltdg.

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
CUR_DIR=`pwd`

# Set all files have a mtime of 2015-01-01.
find "$BASE_DIR" -exec touch -t 201501010000 {} \;

# Set all tracked files to have a mtime as per git.
cd $BASE_DIR
for x in $(git ls-tree --full-tree --name-only -r HEAD); do
  touch -t $(date -d "$(git log -1 --format=%ci "${x}")" \
    +%y%m%d%H%M.%S) "${x}";
done
cd $CUR_DIR
