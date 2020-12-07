#!/usr/bin/env bash
WORKSPACE="$(cd "$(dirname "$0")/.." ; pwd -P)"
echo "WORKSPACE=${WORKSPACE}"
cd $WORKSPACE
echo "build-mac" >> "./build/mac.txt" 
git add .
git commit -m "build complete mac"
git pull
git push -u origin main