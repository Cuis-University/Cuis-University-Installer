#!/usr/bin/env bash
# Make a new CuisUniversity release: build the image (steps 1-5, via createCuisUniversityImage.sh),
# then package and publish it (steps 6-7): zip the -full/-slim archives and publish the GitHub release.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Build the CuisUniversity image (steps 1-5)"
bash "$DIR/createCuisUniversityImage.sh"

echo "==> [6] zip CuisUniversity"
bash "$DIR/6-zipCuisUniversity.sh"

echo "==> [7] publish GitHub release"
bash "$DIR/7-createGitHubRelease.sh"

echo "==> Done. Published the release; -full.zip / -slim.zip are also in $DIR"
