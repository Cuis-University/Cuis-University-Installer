#!/usr/bin/env bash
# Step 1 + 2: fresh (history-less) clone of Cuis-Smalltalk-Dev into the installer dir, then clone the
# package repos into its Packages/.  NOTE: cuis-code-coverage has NO .git suffix (matches its origin).
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLONE="$INSTALLER_DIR/Cuis-Smalltalk-Dev"
DEV_URL="https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev.git"

PACKAGE_REPOS=(
  "Measures|https://github.com/Cuis-Smalltalk/Measures.git"
  "Calendars|https://github.com/Cuis-Smalltalk/Calendars.git"
  "LiveTyping|https://github.com/hernanwilkinson/LiveTyping.git"
  "Cuis-Smalltalk-DenotativeObject|https://github.com/hernanwilkinson/Cuis-Smalltalk-DenotativeObject.git"
  "Cuis-Smalltalk-Refactoring|https://github.com/hernanwilkinson/Cuis-Smalltalk-Refactoring.git"
  "Cuis-University|https://github.com/Cuis-University/Cuis-University.git"
  "TDDGuru|https://github.com/hernanwilkinson/TDDGuru.git"
  "cuis-finder-asWidget|https://github.com/hernanwilkinson/cuis-finder-asWidget.git"
  "cuis-code-coverage|https://github.com/npapagna/cuis-code-coverage"
  "cuis-testlint|https://github.com/Garuflax/cuis-testlint.git"
  "cuis-system-updater|https://github.com/npapagna/cuis-system-updater.git"
  "SystemCategoryAutoSaving|https://github.com/hernanwilkinson/SystemCategoryAutoSaving.git"
  "cuis-pro-extras|https://github.com/joelcamera/cuis-pro-extras.git"
  "MethodFinder|https://github.com/hernanwilkinson/MethodFinder.git"
  "VectorGraphics|https://github.com/Cuis-Smalltalk/VectorGraphics.git"
  "TheCuisBook|https://github.com/Cuis-Smalltalk/TheCuisBook.git"
  "Numerics|https://github.com/Cuis-Smalltalk/Numerics.git"
  "Erudite|https://github.com/Cuis-Smalltalk/Erudite.git"
  "Games|https://github.com/Cuis-Smalltalk/Games.git"
  "Morphic|https://github.com/Cuis-Smalltalk/Morphic.git"
  "Cuis-Smalltalk-Regex|https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Regex.git"
  "Cuis-Smalltalk-Tools|https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Tools.git"
  "OSProcess|https://github.com/Cuis-Smalltalk/OSProcess"
  "Cuis-MCPServer|https://github.com/hernanwilkinson/Cuis-MCPServer"
  "SmalltalkMentor|https://github.com/hernanwilkinson/SmalltalkMentor.git"
)

echo "==> Removing previous CuisUniversity*.zip artifacts"
rm -f "$INSTALLER_DIR"/CuisUniversity*.zip

echo "==> Fresh clone of Cuis-Smalltalk-Dev"
# Robust remove: if a Cuis VM is still writing into the tree, a single `rm -rf` can fail with
# "Directory not empty" (a file reappears between unlink and rmdir). Retry a few times.
if [ -e "$CLONE" ]; then
  for _ in 1 2 3 4 5; do rm -rf "$CLONE" 2>/dev/null && break; sleep 1; done
  [ -e "$CLONE" ] && { echo "error: could not remove $CLONE — a process is still writing to it (close any Cuis VM using it, then retry)" >&2; exit 1; }
fi
git clone --depth 1 "$DEV_URL" "$CLONE"

echo "==> Cloning ${#PACKAGE_REPOS[@]} package repos into Packages/"
mkdir -p "$CLONE/Packages"
for entry in "${PACKAGE_REPOS[@]}"; do
  name="${entry%%|*}"; url="${entry#*|}"
  echo "    - $name"
  rm -rf "$CLONE/Packages/$name"
  git clone --depth 1 "$url" "$CLONE/Packages/$name"
done
