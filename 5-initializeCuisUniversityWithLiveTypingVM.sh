#!/usr/bin/env bash
# Step 6: run the built CuisUniversity image on the LiveTyping VM to do the LiveTyping-specific init
# (CuisUniversityInitializationWithLiveTypingVM.st does the init + saves the image in place). No -u.
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLONE="$INSTALLER_DIR/Cuis-Smalltalk-Dev"

echo "==> LiveTyping init pass"
( cd "$CLONE" && ./RunCuisUniversityOnMac.sh -s ../CuisUniversityInitializationWithLiveTypingVM.st )
