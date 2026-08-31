#!/usr/bin/env bash
# Build the CuisUniversity image (steps 1-5): refresh the environment, create the image with the
# standard Cuis VM, bundle the cross-platform LiveTyping VM, write the launcher scripts, and run the
# LiveTyping initialization pass. The result is a ready-to-run Cuis-Smalltalk-Dev/ tree; packaging
# and publishing (steps 6-7) are done by makeNewRelease.sh.
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

echo "==> CuisUniversity image built (steps 1-5)."
