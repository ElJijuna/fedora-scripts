# fedora-scripts

Installable Linux scripts distributed through GitHub raw URLs.

## Installation

Install all available tools:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/install.sh | bash
```

Install only `webm2gif`:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/install.sh | bash -s -- webm2gif
```

By default, commands are installed in `~/.local/bin` and shared files are installed in `~/.local/share/fedora-scripts`.

## Tools

### webm2gif

Converts `.webm` videos to `.gif` using `ffmpeg`.

Usage:

```bash
webm2gif video.webm
```

This creates `video.gif` next to the original file.

If `ffmpeg` is missing, `webm2gif` will try to install it automatically on Fedora:

```bash
sudo dnf install -y ffmpeg
```

## Uninstall

Remove all installed tools and shared files:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/uninstall.sh | bash
```

Remove only `webm2gif`:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/uninstall.sh | bash -s -- webm2gif
```
