#!/bin/bash
set -e

FILEBROWSER_CONFIG="/workspace/filebrowser_config.yaml"

# Set credentials from environment variables or generate random password
ADMIN_USER="${FILEBROWSER_USER:-admin}"
if [[ -z "$FILEBROWSER_PASSWORD" ]]; then
    ADMIN_PASSWORD=$(openssl rand -base64 12)
    echo "=============================================="
    echo "Generated FileBrowser Quantum credentials:"
    echo "Username: ${ADMIN_USER}"
    echo "Password: ${ADMIN_PASSWORD}"
    echo "=============================================="
else
    ADMIN_PASSWORD="$FILEBROWSER_PASSWORD"
fi

# Create FileBrowser Quantum configuration if it doesn't exist
if [ ! -f "$FILEBROWSER_CONFIG" ]; then
    echo "Creating FileBrowser Quantum configuration..."
    cat > "$FILEBROWSER_CONFIG" << EOF
server:
  port: 8080
  baseURL: "/"
  database: "/workspace/filebrowser.db"
  cacheDir: "/workspace/.cache"
  sources:
    - path: "/workspace"
      name: "Workspace"
      config:
        defaultEnabled: true

auth:
  tokenExpirationHours: 168
  adminUsername: "${ADMIN_USER}"
  adminPassword: "${ADMIN_PASSWORD}"
  methods:
    password:
      enabled: true
      minLength: 5
      signup: false

frontend:
  name: "RunPod FileBrowser"
  disableDefaultLinks: true
EOF
    echo "FileBrowser Quantum configuration created"
else
    echo "Using existing FileBrowser Quantum configuration..."
fi

# Start FileBrowser Quantum
echo "Starting FileBrowser Quantum on port 8080..."
exec filebrowser -c "$FILEBROWSER_CONFIG"
