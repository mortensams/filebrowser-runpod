# FileBrowser Quantum - RunPod Template

Lightweight FileBrowser Quantum image for RunPod with minimal footprint.

## Features

- **Ultra-lightweight**: < 100 MB container size
- **Persistent storage**: All data stored in `/workspace` volume
- **Secure by default**: Random password generation if not configured
- **Simple configuration**: Environment variables for credentials

## Access

- **Port 8080**: FileBrowser Quantum web interface
- **Default directory**: `/workspace`

## Configuration

Configure credentials via environment variables:

- `FILEBROWSER_USER`: Admin username (default: `admin`)
- `FILEBROWSER_PASSWORD`: Admin password (default: randomly generated and shown in logs)

If you don't set `FILEBROWSER_PASSWORD`, a random password will be generated on first startup and displayed in the container logs.

## Usage

### RunPod Template

1. Deploy this template on RunPod
2. Check the logs for the generated password if you didn't set `FILEBROWSER_PASSWORD`
3. Access FileBrowser on port 8080
4. Log in with your credentials

### Local Testing

```bash
docker build -t filebrowser-quantum .
docker run -p 8080:8080 -v $(pwd)/workspace:/workspace filebrowser-quantum
```

## Directory Structure

- `/workspace`: Default directory (mounted as RunPod volume)
- `/workspace/filebrowser.db`: FileBrowser database
- `/workspace/.cache`: FileBrowser cache
- `/workspace/filebrowser_config.yaml`: Configuration file (auto-generated on first start)

## Source Code

This template is open source. Source code available at: [github.com/mortensams/filebrowser-quantum-runpod](https://github.com/mortensams/filebrowser-quantum-runpod)
