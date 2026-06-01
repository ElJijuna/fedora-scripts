#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
SHARE_DIR="${SHARE_DIR:-$HOME/.local/share/fedora-scripts}"

usage() {
  cat <<'USAGE'
Usage: uninstall.sh [tool]

Tools:
  webm2gif    Remove the webm2gif command
  all         Remove all installed tools and shared files

Examples:
  bash uninstall.sh webm2gif
  bash uninstall.sh all
USAGE
}

remove_file() {
  local path="$1"

  if [[ -e "$path" ]]; then
    rm -f "$path"
    printf 'Removed %s\n' "$path"
  else
    printf 'Not installed: %s\n' "$path"
  fi
}

remove_empty_dirs() {
  local path="$1"

  while [[ "$path" != "/" && "$path" != "$HOME" ]]; do
    rmdir "$path" 2>/dev/null || break
    printf 'Removed empty directory %s\n' "$path"
    path="$(dirname "$path")"
  done
}

uninstall_webm2gif() {
  remove_file "$INSTALL_DIR/webm2gif"
}

uninstall_shared_files() {
  remove_file "$SHARE_DIR/lib/logger.sh"
  remove_empty_dirs "$SHARE_DIR/lib"
  remove_empty_dirs "$SHARE_DIR"
}

TOOL="${1:-all}"

case "$TOOL" in
  webm2gif|webm-to-gif)
    uninstall_webm2gif
    ;;
  all)
    uninstall_webm2gif
    uninstall_shared_files
    ;;
  -h|--help|help)
    usage
    exit 0
    ;;
  *)
    usage >&2
    printf 'uninstall: unknown tool: %s\n' "$TOOL" >&2
    exit 1
    ;;
esac
