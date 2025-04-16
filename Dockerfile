FROM ubuntu:22.04

# Install dependencies
RUN apt update && \
    apt install -y libx11-6 libxcursor1 libxrandr2 libxi6 libasound2 libpulse0 libudev1 && \
    apt clean

# Copy exported Godot headless binary
COPY card_server.x86_64 /app/card_server
RUN chmod +x /app/card_server

# Run your game server with optional args
WORKDIR /app
CMD ["./card_server", "--server"]
