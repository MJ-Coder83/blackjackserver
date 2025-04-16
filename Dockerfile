FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && apt-get install -y \
    libx11-6 \
    libxcursor1 \
    libxrandr2 \
    libxi6 \
    libasound2 \
    libpulse0 \
    libudev1 \
    && apt-get clean

WORKDIR /app
COPY card_server.x86_64 /app/card_server
RUN chmod +x /app/card_server

CMD ["./card_server", "--server"]
