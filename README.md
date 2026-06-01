# fedora-scripts

Scripts instalables desde GitHub para Fedora y Linux de escritorio.

## Herramientas

### webm2gif

Convierte videos `.webm` a `.gif` usando `ffmpeg`.

Instalacion desde la URL raw de GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/install.sh | bash
```

Tambien puedes instalar solo esta herramienta:

```bash
curl -fsSL https://raw.githubusercontent.com/ElJijuna/fedora-scripts/main/install.sh | bash -s -- webm2gif
```

Si falta `ffmpeg`, el script intentara instalarlo con `sudo dnf install -y ffmpeg`.
Tambien puedes instalarlo manualmente:

```bash
sudo dnf install ffmpeg
```

Uso:

```bash
webm2gif video.webm
```

Esto crea `video.gif` junto al archivo original.
