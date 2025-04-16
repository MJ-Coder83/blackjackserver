#!/bin/bash
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"
if [ "$ARCH" = "x86_64" ]; then
  echo "Using x86_64 binary"
  chmod +x /app/card_server.x86_64
  exec /app/card_server.x86_64 --server
elif [ "$ARCH" = "aarch64" ]; then
  echo "Using ARM64 binary"
  chmod +x /app/card_server.arm64
  exec /app/card_server.arm64 --server
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi
