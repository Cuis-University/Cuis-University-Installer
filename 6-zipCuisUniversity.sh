#!/usr/bin/env bash
# Step 7: zip the finished distribution directory into TWO archives, both version-stamped from the built
# CuisUniversity image name (e.g. CuisUniversity7.9-8139):
#   - <name>-full.zip   the complete tree
#   - <name>-slim.zip    without dev/history/media cruft (all .git/.github, CoreUpdates, PreviousUpdates,
#                        and the heavy LiveTyping subdirs) -- everything needed to RUN is kept.
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLONE="$INSTALLER_DIR/Cuis-Smalltalk-Dev"

# Derive the version-stamped zip name from the CuisUniversity image (newest, in case several exist).
IMG=$(ls -t "$CLONE"/CuisImage/CuisUniversity*.image 2>/dev/null | head -1)
[[ -n "$IMG" ]] || { echo "error: no CuisUniversity*.image in $CLONE/CuisImage to name the zip" >&2; exit 1; }
NAME="$(basename "$IMG" .image)"   # e.g. CuisUniversity7.9-8139

cd "$INSTALLER_DIR"

echo "==> Zipping (full) Cuis-Smalltalk-Dev -> $NAME-full.zip"
rm -f "$NAME-full.zip"
zip -r -q "$NAME-full.zip" Cuis-Smalltalk-Dev -x '*/.DS_Store'

# Slim: drop dev/history/media data unused for running the distribution.
# zip's `*` spans `/`, so `*/.git*` matches .git / .gitignore / .gitattributes / .gitmodules AND .github
# at any depth (Cuis-Smalltalk-Dev + every Packages/<repo>).
SLIM_EXCLUDES=(
  '*/.DS_Store'
  '*/.git*'
  'Cuis-Smalltalk-Dev/CoreUpdates/*'
  'Cuis-Smalltalk-Dev/PreviousUpdates/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Presentations/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Python/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Ruby/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Smalltalk/image/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Smalltalk/VMMaker/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Smalltalk/VMs/*'
  'Cuis-Smalltalk-Dev/Packages/LiveTyping/Smalltalk/VMSources/*'
)
echo "==> Zipping (slim) Cuis-Smalltalk-Dev -> $NAME-slim.zip"
rm -f "$NAME-slim.zip"
zip -r -q "$NAME-slim.zip" Cuis-Smalltalk-Dev -x "${SLIM_EXCLUDES[@]}"

echo "==> Created in $INSTALLER_DIR:"
ls -lh "$NAME-full.zip" "$NAME-slim.zip" | sed 's/^/    /'
