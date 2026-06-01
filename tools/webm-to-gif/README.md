# webm2gif

Convert `.webm` files to `.gif` from the terminal.

## Install

Install the `webm2gif` command in `~/.local/bin`:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/install.sh | bash -s -- webm2gif
```

If `ffmpeg` is missing, the script will try to install it automatically on Fedora.
You can also install it manually:

```bash
sudo dnf install -y ffmpeg
```

## Usage

```bash
webm2gif video.webm
```

This creates `video.gif` in the same directory.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/uninstall.sh | bash -s -- webm2gif
```
