#!/usr/bin/env bash
# Build the CuisUniversity distribution end-to-end by running the numbered step scripts in order.
# (Renamed from bundleLiveTypingVM.sh; each of the 7 original steps now lives in its own N-*.sh.)
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> [1] refresh environment (clone Cuis-Smalltalk-Dev + package repos)"
bash "$DIR/1-refreshEnvironment.sh"

echo "==> [2] create the CuisUniversity image"
bash "$DIR/2-createCuisUniversityImage.sh"

echo "==> [3] bundle the LiveTyping VM"
bash "$DIR/3-bundleLiveTypingVM.sh"

echo "==> [4] create the launcher scripts"
bash "$DIR/4-createLauncherScripts.sh"

echo "==> [5] initialize CuisUniversity with the LiveTyping VM"
bash "$DIR/5-initializeCuisUniversityWithLiveTypingVM.sh"

echo "==> [6] zip CuisUniversity"
bash "$DIR/6-zipCuisUniversity.sh"

echo "==> [7] publish GitHub release"
bash "$DIR/7-createGitHubRelease.sh"

echo "==> Done. Published the release; -full.zip / -slim.zip are also in $DIR"
