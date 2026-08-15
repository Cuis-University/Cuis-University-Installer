#!/usr/bin/env bash
# Step 3: build the CuisUniversity image with the standard CuisVM via RunCuisOnMac.sh.
# RunCuisOnMac.sh runs `./CuisVM.app … CuisImage/Cuis?.?-????.image -u "$@"`: -u applies all CoreUpdates,
# then CuisUniversityInstallation.st loads the packages (by Feature name) and saves
# CuisImage/CuisUniversity7.9-<n>.image.
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLONE="$INSTALLER_DIR/Cuis-Smalltalk-Dev"

echo "==> Building CuisUniversity image"
( cd "$CLONE" && bash ./RunCuisOnMac.sh -s ../CuisUniversityInstallation.st )
