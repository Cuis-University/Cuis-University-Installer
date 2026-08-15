#!/usr/bin/env bash
# Step 4: assemble LiveTypingVM.app INTO the clone from the built LiveTyping VM products —
# a universal macOS Squeak (lipo of arm64 + x86_64, shared plugins too; ad-hoc codesigned) plus
# Linux-x86_64 / Linux-arm64 / Windows-x86_64 / Windows-arm64. macOS host required (lipo/codesign).
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRODUCTS="/Users/hernan/Documents/VM/opensmalltalk-vm-ephemerons/products"

MAC_ARM="$PRODUCTS/macos64ARMv8/SqueakLiveTyping.app"
MAC_X64="$PRODUCTS/macos64x64/SqueakLiveTyping.app"
LINUX_X64="$PRODUCTS/sqcogspurlt64linuxht"
LINUX_ARM="$PRODUCTS/sqcogspurlt64ARMv8linuxht"
WIN_X64="$PRODUCTS/SqueakLiveTyping-win64x64"
WIN_ARM="$PRODUCTS/SqueakLiveTyping-win64ARM64"

CLONE="$INSTALLER_DIR/Cuis-Smalltalk-Dev"
APP="$CLONE/LiveTypingVM.app"
CONTENTS="$APP/Contents"

for p in "$MAC_ARM" "$MAC_X64" "$LINUX_X64" "$LINUX_ARM" "$WIN_X64" "$WIN_ARM"; do
  [[ -e "$p" ]] || { echo "error: missing source: $p" >&2; exit 1; }
done

echo "==> Assembling $APP"
rm -rf "$APP"
mkdir -p "$CONTENTS/MacOS"

# macOS: arm64 app is the base (Info.plist, Resources incl. all plugin bundles + icons), then make the
# main VM and every shared plugin universal via lipo.
echo "    macOS: base from arm64 app + lipo universal"
cp "$MAC_ARM/Contents/Info.plist" "$CONTENTS/Info.plist"
cp -R "$MAC_ARM/Contents/MacOS/." "$CONTENTS/MacOS/"       # keep any helper files, Squeak overwritten below
cp -R "$MAC_ARM/Contents/Resources" "$CONTENTS/Resources"

lipo -create "$MAC_ARM/Contents/MacOS/Squeak" "$MAC_X64/Contents/MacOS/Squeak" \
     -output "$CONTENTS/MacOS/Squeak"
chmod +x "$CONTENTS/MacOS/Squeak"

RES="$CONTENTS/Resources"
UNIV=()   # universal plugin binaries that need re-signing
for b in "$RES"/*.bundle; do
  [[ -d "$b/Contents/MacOS" ]] || continue
  for innerbin in "$b/Contents/MacOS"/*; do
    [[ -f "$innerbin" ]] || continue
    rel="${innerbin#$RES/}"                                # e.g. SqueakSSL.bundle/Contents/MacOS/SqueakSSL
    x64bin="$MAC_X64/Contents/Resources/$rel"
    [[ -f "$x64bin" ]] || continue                         # arm-only plugin (e.g. Bochs/Gdb): leave as-is
    if lipo -create "$innerbin" "$x64bin" -output "$innerbin.univ" 2>/dev/null; then
      mv "$innerbin.univ" "$innerbin"
      UNIV+=("$innerbin")
    else
      rm -f "$innerbin.univ"
      echo "    warn: could not lipo $rel (keeping arm64 slice)"
    fi
  done
done
echo "    universal plugins: ${#UNIV[@]}"

echo "    Linux x86_64 + arm64"
cp -R "$LINUX_X64" "$CONTENTS/Linux-x86_64"
cp -R "$LINUX_ARM" "$CONTENTS/Linux-arm64"

echo "    Windows x86_64 + arm64"
cp -R "$WIN_X64" "$CONTENTS/Windows-x86_64"
cp -R "$WIN_ARM" "$CONTENTS/Windows-arm64"

# Ad-hoc re-sign AFTER all Contents/ folders are in place (lipo strips signatures; Apple Silicon won't
# run an unsigned arm64 binary). Sign nested plugins first, then seal the bundle.
echo "    codesign (ad-hoc): ${#UNIV[@]} universal plugins, then the bundle"
if ((${#UNIV[@]})); then
  for pb in "${UNIV[@]}"; do codesign --force --sign - "$pb"; done
fi
codesign --force --sign - "$APP"

echo "==> LiveTypingVM.app assembled ($(lipo -archs "$CONTENTS/MacOS/Squeak" 2>/dev/null))"
