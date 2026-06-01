#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_URL="${REPO_RAW_URL:-https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"

usage() {
  cat <<'USAGE'
Usage: install.sh [tool]

Tools:
  webm2gif    Convert .webm videos to .gif
  all         Install all tools

Examples:
  bash install.sh webm2gif
  bash install.sh all
USAGE
}

die() {
  printf 'install: %s\n' "$*" >&2
  exit 1
}

download() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
  else
    die "missing dependency: curl or wget"
  fi
}

install_script() {
  local source_path="$1"
  local command_name="$2"
  local target="$INSTALL_DIR/$command_name"

  mkdir -p "$INSTALL_DIR"
  download "$REPO_RAW_URL/$source_path" "$target"
  chmod +x "$target"

  printf 'Installed %s at %s\n' "$command_name" "$target"
}

install_webm2gif() {
  install_script "tools/webm-to-gif/webm-to-gif.sh" "webm2gif"

  if ! command -v ffmpeg >/dev/null 2>&1; then
    printf '\nffmpeg is required to convert videos.\n'
    printf 'The webm2gif command will try to install it automatically on Fedora.\n'
    printf 'You can also install it manually with:\n'
    printf '  sudo dnf install -y ffmpeg\n'
  fi
}

TOOL="${1:-all}"

case "$TOOL" in
  webm2gif|webm-to-gif)
    install_webm2gif
    ;;
  all)
    install_webm2gif
    ;;
  -h|--help|help)
    usage
    exit 0
    ;;
  *)
    usage >&2
    die "unknown tool: $TOOL"
    ;;
esac

case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    printf '\nAdd this directory to PATH if your shell cannot find the installed commands:\n'
    printf '  export PATH="%s:$PATH"\n' "$INSTALL_DIR"
    ;;
esac

printf '\nTry it with:\n'
printf '  webm2gif video.webm\n'
