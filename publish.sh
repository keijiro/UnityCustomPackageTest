#!/bin/sh

PACKAGE_ID="jp.keijiro.unity-custom-package-test"

set -eu

TAG=$(git describe --tags --exact-match 2>/dev/null || true)

if [ -z "$TAG" ]; then
  echo "Error: No Git tag found for this commit."
  exit 1
fi

VERSION="$TAG"
TARBALL="${PACKAGE_ID}-${VERSION}.tgz"

if [ ! -f "$TARBALL" ]; then
  echo "Error: Tarball not found: $TARBALL"
  exit 1
fi

COMMIT_MSG=$(git log -1 --pretty=%B)
TITLE=$(printf "%s\n" "$COMMIT_MSG" | head -n 1)
BODY=$(printf "%s\n" "$COMMIT_MSG" | tail -n +2)

if gh release view "$TAG" >/dev/null 2>&1; then
  echo "GitHub release '$TAG' already exists."
else
  echo "Creating GitHub Release for tag $TAG..."
  gh release create "$TAG" "$TARBALL"  --title "$TITLE" --notes "$BODY"
fi

if npm view "$PACKAGE_ID@$VERSION" >/dev/null 2>&1; then
  echo "npm package '$PACKAGE_ID@$VERSION' already exists."
else
  echo "Publishing to npm..."
  npm publish "$TARBALL" --access public
fi

