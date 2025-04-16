FROM ubuntu:22.04

# Install Godot dependencies
RUN apt-get update && apt-get install -y \
    libx11-6 \
    libxcursor1 \
    libxrandr2 \
    libxi6 \
    libasound2 \
    libpulse0 \
    libudev1 \
    ca-certificates \
    file \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy server binaries
COPY card_server.x86_64 /app/card_server.x86_64
# Try to copy ARM64 binary but don't fail if it doesn't exist
COPY *.arm64 /app/ 2>/dev/null || echo "No ARM64 binary found"

# Copy PCK file
COPY card_server.pck /app/

# Create a startup script that selects the correct binary
RUN echo '#!/bin/bash\n\
ARCH=$(uname -m)\n\
echo "Detected architecture: $ARCH"\n\
if [ "$ARCH" = "x86_64" ]; then\n\
  echo "Using x86_64 binary"\n\
  chmod +x /app/card_server.x86_64\n\
  exec /app/card_server.x86_64 --server\n\
elif [ "$ARCH" = "aarch64" ]; then\n\
  if [ -f "/app/card_server.arm64" ]; then\n\
    echo "Using ARM64 binary"\n\
    chmod +x /app/card_server.arm64\n\
    exec /app/card_server.arm64 --server\n\
  else\n\
    echo "ARM64 binary not found, trying with x86_64 binary"\n\
    chmod +x /app/card_server.x86_64\n\
    exec /app/card_server.x86_64 --server\n\
  fi\n\
else\n\
  echo "Unsupported architecture: $ARCH"\n\
  exit 1\n\
fi' > /app/start.sh && chmod +x /app/start.sh

# Run the startup script
CMD ["/app/start.sh"]