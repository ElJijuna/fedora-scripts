#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LOGGER_PATHS=()

if [[ -n "${FEDORA_SCRIPTS_LIB_DIR:-}" ]]; then
  LOGGER_PATHS+=("$FEDORA_SCRIPTS_LIB_DIR/logger.sh")
fi

LOGGER_PATHS+=(
  "$SCRIPT_DIR/../../lib/logger.sh"
  "$HOME/.local/share/fedora-scripts/lib/logger.sh"
)

for LOGGER_PATH in "${LOGGER_PATHS[@]}"; do
  if [[ -f "$LOGGER_PATH" ]]; then
    # shellcheck source=/dev/null
    source "$LOGGER_PATH"
    break
  fi
done

if ! declare -F log_info >/dev/null 2>&1; then
  log_info() { printf '[INFO] %s\n' "$*"; }
  log_success() { printf '[OK] %s\n' "$*"; }
  log_warn() { printf '[WARN] %s\n' "$*" >&2; }
  log_error() { printf '[ERROR] %s\n' "$*" >&2; }
fi

INPUT="${1:-}"

if [[ -z "$INPUT" ]]; then
  log_error "Usage: webm2gif file.webm"
  exit 1
fi

if [[ ! -f "$INPUT" ]]; then
  log_error "File not found: $INPUT"
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  log_warn "ffmpeg not found. Installing ffmpeg..."
  sudo dnf install -y ffmpeg
fi

OUTPUT="${INPUT%.*}.gif"
PALETTE="$(mktemp --suffix=.png)"

cleanup() {
  rm -f "$PALETTE"
}
trap cleanup EXIT

log_info "Creating palette..."
ffmpeg -hide_banner -loglevel error -y -i "$INPUT" \
  -vf "fps=15,scale=iw:-1:flags=lanczos,palettegen" \
  "$PALETTE"

log_info "Converting to GIF..."
ffmpeg -hide_banner -loglevel error -y -i "$INPUT" -i "$PALETTE" \
  -lavfi "fps=15,scale=iw:-1:flags=lanczos[x];[x][1:v]paletteuse" \
  "$OUTPUT"

log_success "Done: $OUTPUT"
