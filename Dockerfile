FROM node:20-bookworm

# Set working directory
WORKDIR /app

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    tar \
    curl \
    bash \
 && rm -rf /var/lib/apt/lists/*

# Download and extract Hytale Server Manager
RUN curl -L \
    https://github.com/nebula-codes/hytale_server_manager/releases/download/v0.2.31/hytale-server-manager-0.2.31-linux.tar.gz \
    -o hytale-server-manager.tar.gz \
 && tar -xzf hytale-server-manager.tar.gz \
 && rm hytale-server-manager.tar.gz

WORKDIR /app/hytale-server-manager

# Install application dependencies (NO sudo in Docker)
RUN chmod +x install.sh && ./install.sh

# Create persistent directories
RUN mkdir -p data servers backups logs

# Expose the app port
EXPOSE 3001

# Use environment variables at runtime
CMD ["npm", "run", "start"]
