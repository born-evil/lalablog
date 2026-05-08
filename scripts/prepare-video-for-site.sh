#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
EXIFTOOL="$ROOT_DIR/Image-ExifTool-13.50/exiftool"
SWIFT_CACHE_DIR="${TMPDIR:-/private/tmp}/lala-swift-module-cache"

if [ "$#" -lt 1 ]; then
  echo "Usage:"
  echo "  ./scripts/prepare-video-for-site.sh path/to/video.mp4"
  echo "  ./scripts/prepare-video-for-site.sh path/to/video1.mp4 path/to/video2.mov"
  exit 1
fi

if [ ! -x "$EXIFTOOL" ]; then
  echo "Could not find ExifTool at: $EXIFTOOL"
  echo "Stop here and ask Codex for help."
  exit 1
fi

mkdir -p "$SWIFT_CACHE_DIR"

for video_path in "$@"; do
  if [ ! -f "$video_path" ]; then
    echo "Skipping missing file: $video_path"
    continue
  fi

  extension="${video_path##*.}"
  extension="${extension:l}"
  if [[ "$extension" != "mp4" && "$extension" != "mov" && "$extension" != "m4v" ]]; then
    echo "Skipping unsupported video file: $video_path"
    continue
  fi

  temp_output="${video_path%.*}.site-compressed.mp4"
  echo "Compressing video for site: $video_path"
  SWIFTC_MODULECACHE_PATH="$SWIFT_CACHE_DIR" CLANG_MODULE_CACHE_PATH="$SWIFT_CACHE_DIR" swift "$ROOT_DIR/scripts/compress-video.swift" "$video_path" "$temp_output"

  echo "Removing metadata from: $temp_output"
  "$EXIFTOOL" -overwrite_original -all= "$temp_output" >/dev/null

  mv "$temp_output" "$video_path"
  echo "Done: $video_path"
done

echo "Finished preparing video files for the site."
