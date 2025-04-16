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
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy server binary and PCK file
COPY card_server.x86_64 /app/card_server
COPY card_server.pck /app/

# Make the binary executable
RUN chmod +x /app/card_server

# Run the server with the --server flag
CMD ["./card_server", "--server"]