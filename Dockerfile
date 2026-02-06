# Lightweight FileBrowser Quantum for RunPod
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install minimal dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    wget \
    ca-certificates \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install FileBrowser Quantum
RUN wget -O /usr/local/bin/filebrowser https://github.com/gtsteffaniak/filebrowser/releases/download/v1.1.1-stable/linux-amd64-filebrowser && \
    chmod +x /usr/local/bin/filebrowser

# Create workspace directory
RUN mkdir -p /workspace

WORKDIR /workspace

# Expose FileBrowser port
EXPOSE 8080

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
