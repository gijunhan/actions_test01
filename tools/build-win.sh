#!/usr/bin/env bash
WORKSPACE="$(cd "$(dirname "$0")/.." ; pwd -P)"
echo "WORKSPACE=${WORKSPACE}"
cd $WORKSPACE
git pull
echo "build-win" >> "./build/win.txt"
git config --global user.email "gijun.han@gree.net"
git config --global user.name "gijun.han"
git add .
git commit -m "build complete win"
git push -u origin main
