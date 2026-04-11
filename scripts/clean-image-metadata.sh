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
  echo "  ./scripts/clean-image-metadata.sh path/to/image.jpg"
  echo "  ./scripts/clean-image-metadata.sh path/to/image1.jpg path/to/image2.png"
  exit 1
fi

for image_path in "$@"; do
  if [ ! -f "$image_path" ]; then
    echo "Skipping missing file: $image_path"
    continue
  fi

  echo "Cleaning metadata from: $image_path"
  "$EXIFTOOL" -overwrite_original -all= "$image_path" >/dev/null

  extension="${image_path##*.}"
  extension="${extension:l}"

  case "$extension" in
    jpg|jpeg)
      # Re-save JPEGs so Astro has normal image metadata to work with.
      sips -s format jpeg "$image_path" --out "$image_path" >/dev/null
      ;;
  esac

  echo "Done: $image_path"
done

echo "Finished cleaning image metadata."
