# webm2gif

Convierte archivos `.webm` a `.gif` desde terminal.

## Instalacion

Instala el comando `webm2gif` en `~/.local/bin`:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/install.sh | bash -s -- webm2gif
```

Si falta `ffmpeg`, el script intentara instalarlo con `sudo dnf install -y ffmpeg`.
Tambien puedes instalarlo manualmente:

```bash
sudo dnf install ffmpeg
```

## Uso

```bash
webm2gif video.webm
```

Esto crea `video.gif` en el mismo directorio.
