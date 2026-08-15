#!/usr/bin/env bash
# Step 5: write the minimal RunCuisUniversityOnMac.sh / RunCuisUniversityOnLinux.sh / RunCuisUniversityOnWindows.bat launchers into the clone.
# They open the CuisUniversity image (glob CuisImage/CuisUniversity*.image): exactly one match -> open
# it; zero or several -> run the VM with no image name so its own picker opens. Any extra args ("$@")
# are forwarded (used by step 6). No -u.
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLONE="$INSTALLER_DIR/Cuis-Smalltalk-Dev"

echo "==> Launch scripts"
cat > "$CLONE/RunCuisUniversityOnMac.sh" <<'EOF'
#!/bin/sh
# Open the CuisUniversity image on the LiveTyping VM (macOS).
cd "$(dirname "$0")" || exit 1
VM=./LiveTypingVM.app/Contents/MacOS/Squeak
count=0; image=""
for f in CuisImage/CuisUniversity*.image; do
  [ -f "$f" ] || continue
  count=$((count+1)); image="$f"
done
if [ "$count" -eq 1 ]; then
  exec "$VM" "$image" "$@"
else
  exec "$VM" "$@"
fi
EOF

cat > "$CLONE/RunCuisUniversityOnLinux.sh" <<'EOF'
#!/bin/sh
# Open the CuisUniversity image on the LiveTyping VM (Linux).
cd "$(dirname "$0")" || exit 1
CPU=$(uname -m)
[ "$CPU" = "aarch64" ] && CPU=arm64
VM=./LiveTypingVM.app/Contents/Linux-${CPU}/squeak
count=0; image=""
for f in CuisImage/CuisUniversity*.image; do
  [ -f "$f" ] || continue
  count=$((count+1)); image="$f"
done
if [ "$count" -eq 1 ]; then
  exec "$VM" "$image" "$@"
else
  exec "$VM" "$@"
fi
EOF

chmod +x "$CLONE/RunCuisUniversityOnMac.sh" "$CLONE/RunCuisUniversityOnLinux.sh"

# RunCuisUniversityOnWindows.bat (CRLF for cmd.exe). Picks Windows-arm64 or Windows-x86_64 by
# %PROCESSOR_ARCHITECTURE% (also PROCESSOR_ARCHITEW6432 for emulated shells), falling back to x86_64
# if the arch-specific exe is missing.
{
  printf '%s\n' '@echo off'
  printf '%s\n' 'cd /d "%~dp0"'
  printf '%s\n' 'set "WINDIR_ARCH=Windows-x86_64"'
  printf '%s\n' 'if /I "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "WINDIR_ARCH=Windows-arm64"'
  printf '%s\n' 'if /I "%PROCESSOR_ARCHITEW6432%"=="ARM64" set "WINDIR_ARCH=Windows-arm64"'
  printf '%s\n' 'set "VM=LiveTypingVM.app\Contents\%WINDIR_ARCH%\SqueakLiveTyping.exe"'
  printf '%s\n' 'if not exist "%VM%" set "VM=LiveTypingVM.app\Contents\Windows-x86_64\SqueakLiveTyping.exe"'
  printf '%s\n' 'setlocal enabledelayedexpansion'
  printf '%s\n' 'set COUNT=0'
  printf '%s\n' 'for %%f in (CuisImage\CuisUniversity*.image) do ('
  printf '%s\n' '  set /a COUNT+=1'
  printf '%s\n' '  set "IMG=%%f"'
  printf '%s\n' ')'
  printf '%s\n' 'if !COUNT! EQU 1 ('
  printf '%s\n' '  start "" "!VM!" "!IMG!" %*'
  printf '%s\n' ') else ('
  printf '%s\n' '  start "" "!VM!" %*'
  printf '%s\n' ')'
} | sed 's/$/\r/' > "$CLONE/RunCuisUniversityOnWindows.bat"
