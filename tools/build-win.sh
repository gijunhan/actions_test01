#!/usr/bin/env bash
WORKSPACE="$(cd "$(dirname "$0")/.." ; pwd -P)"
echo "WORKSPACE=${WORKSPACE}"
cd $WORKSPACE
echo "build-win" >> "./build/win.txt"
git pull
git add .
git commit -m "build complete win"
git push -u origin main
