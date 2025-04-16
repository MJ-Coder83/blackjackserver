FROM --platform=linux/amd64 ubuntu:22.04

# Install Godot dependencies (no display needed for headless)
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

# Copy server binary (must be Linux x86_64 binary)
COPY ./card_server.x86_64 ./card_server
RUN chmod +x ./card_server

# Run the headless server with the --server flag
CMD ["./card_server", "--server"]
