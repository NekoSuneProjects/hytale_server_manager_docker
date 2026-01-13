FROM node:20-bookworm

WORKDIR /app

# System deps
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    bash \
 && rm -rf /var/lib/apt/lists/*

# Download & extract release (extracts directly into /app)
RUN curl -L \
    https://github.com/nebula-codes/hytale_server_manager/releases/download/v0.2.31/hytale-server-manager-0.2.31-linux.tar.gz \
    -o hsm.tar.gz \
 && tar -xzf hsm.tar.gz \
 && rm hsm.tar.gz

# Install dependencies (no sudo in Docker)
RUN chmod +x install.sh && ./install.sh

# Persistent directories
RUN mkdir -p data servers backups logs

EXPOSE 3001

CMD ["npm", "run", "start"]
