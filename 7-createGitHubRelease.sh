#!/usr/bin/env bash
# Step 7 (final): publish a GitHub release for the two VERSION-named zips on Cuis-University/Cuis-University
# (assets keep the version in their names, e.g. CuisUniversity7.9-8139-full.zip / -slim.zip).
#
# Permanent, per-zip download links for the CuisUniversity site come from the GitHub Pages redirect pages
# (github-pages/full.html, github-pages/slim.html). Those pages ask the GitHub API for the LATEST release's
# *-full.zip / *-slim.zip asset and forward to it -- so they are static (committed once) and this step does
# NOT touch them; it only needs to publish the release and mark it "Latest".
#
# Requires the GitHub CLI `gh`, authenticated (gh auth login) with write access to the repo.
set -euo pipefail
INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="Cuis-University/Cuis-University"

FULL=$(ls -t "$INSTALLER_DIR"/CuisUniversity*-full.zip 2>/dev/null | head -1)
SLIM=$(ls -t "$INSTALLER_DIR"/CuisUniversity*-slim.zip 2>/dev/null | head -1)
[[ -n "$FULL" && -n "$SLIM" ]] || { echo "error: full/slim zip not found in $INSTALLER_DIR (run 6-zipCuisUniversity.sh first)" >&2; exit 1; }

NAME="$(basename "$FULL" -full.zip)"   # e.g. CuisUniversity7.9-8139
TAG="v${NAME##*-}"                       # e.g. v8139  (matches the existing release tag convention)

command -v gh >/dev/null || { echo "error: gh (GitHub CLI) not installed -- brew install gh" >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "error: gh not authenticated -- run: gh auth login" >&2; exit 1; }

echo "==> Publishing release $TAG to $REPO  ($(basename "$FULL") / $(basename "$SLIM"))"
if gh release view "$TAG" --repo "$REPO" >/dev/null 2>&1; then
  echo "    release $TAG already exists -- updating its assets (--clobber) and marking it latest"
  gh release upload "$TAG" "$FULL" "$SLIM" --repo "$REPO" --clobber
  gh release edit "$TAG" --repo "$REPO" --latest >/dev/null
else
  gh release create "$TAG" "$FULL" "$SLIM" --repo "$REPO" --title "$NAME" --latest \
    --notes "CuisUniversity distribution built from Cuis update ${NAME##*-}. Download the full or slim zip below."
fi

echo "==> Released: https://github.com/$REPO/releases/tag/$TAG"
echo "    permanent site links (via GitHub Pages redirects):"
echo "      full: https://cuis-university.github.io/Cuis-University/full.html"
echo "      slim: https://cuis-university.github.io/Cuis-University/slim.html"
