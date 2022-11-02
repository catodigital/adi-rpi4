#!/bin/bash

set -euo pipefail

type=$1
target=$2
base="/artifacts/jenkins"
REPO=$(basename $GIT_URL | sed -e s/\.git$//)

case "$target" in
  restore)
    # if it's already there do nothing
    if [ -d "_build/$MIX_ENV" ]; then
      echo "==> Build artifacts already in place, not synchronizing"
    else
      mkdir -p _build
      echo "==> Restoring build artifacts to workspace"
      rsync -va $base/${REPO}/${type}/_build/. _build/.
    fi
    ;;

  archive)
    folder="$base/$REPO/$type/_build"
    echo "==> Archiving build artifacts"
    mkdir -p $folder
    rsync -va --delete _build/. $folder/.
    ;;
esac
