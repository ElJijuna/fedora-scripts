#!/usr/bin/env bash

if [[ -t 1 || -t 2 ]] && [[ -z "${NO_COLOR:-}" ]]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  BLUE='\033[0;34m'
  NC='\033[0m'
else
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  NC=''
fi

log_info() {
  printf "${BLUE}[INFO]${NC} %s\n" "$*"
}

log_success() {
  printf "${GREEN}[OK]${NC} %s\n" "$*"
}

log_warn() {
  printf "${YELLOW}[WARN]${NC} %s\n" "$*" >&2
}

log_error() {
  printf "${RED}[ERROR]${NC} %s\n" "$*" >&2
}
