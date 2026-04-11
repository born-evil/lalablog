#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
EXIFTOOL="$ROOT_DIR/Image-ExifTool-13.50/exiftool"

if [ ! -x "$EXIFTOOL" ]; then
  echo "Could not find ExifTool at: $EXIFTOOL"
  echo "Stop here and ask Codex for help."
  exit 1
fi

if [ "$#" -lt 1 ]; then
  echo "Usage:"
  echo "  ./scripts/check-image-metadata.sh path/to/image.jpg"
  echo "  ./scripts/check-image-metadata.sh path/to/image1.jpg path/to/image2.png"
  exit 1
fi

for image_path in "$@"; do
  if [ ! -f "$image_path" ]; then
    echo "Skipping missing file: $image_path"
    continue
  fi

  echo
  echo "===== $image_path ====="
  "$EXIFTOOL" "$image_path"
done
