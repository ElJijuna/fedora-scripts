#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-}"

if [[ -z "$INPUT" ]]; then
  echo "Usage: webm2gif file.webm"
  exit 1
fi

if [[ ! -f "$INPUT" ]]; then
  echo "File not found: $INPUT"
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "Installing ffmpeg..."
  sudo dnf install -y ffmpeg
fi

OUTPUT="${INPUT%.*}.gif"
PALETTE="$(mktemp --suffix=.png)"

cleanup() {
  rm -f "$PALETTE"
}
trap cleanup EXIT

echo "Creating palette..."
ffmpeg -hide_banner -loglevel error -y -i "$INPUT" \
  -vf "fps=15,scale=iw:-1:flags=lanczos,palettegen" \
  "$PALETTE"

echo "Converting to GIF..."
ffmpeg -hide_banner -loglevel error -y -i "$INPUT" -i "$PALETTE" \
  -lavfi "fps=15,scale=iw:-1:flags=lanczos[x];[x][1:v]paletteuse" \
  "$OUTPUT"

echo "Done: $OUTPUT"
