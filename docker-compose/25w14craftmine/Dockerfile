FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up
RUN apt update && \
    apt install -y --no-install-recommends \
        curl \
        wget \
        unzip \
        openjdk-21-jre && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and set permissions
RUN useradd -m minecraft && \
    mkdir -p /minecraft /minecraft-data /minecraft-unzipped && \
    chown -R minecraft:minecraft /minecraft /minecraft-unzipped /minecraft-data

# Download and extract the server files
WORKDIR /minecraft-unzipped
RUN wget -q https://piston-data.mojang.com/v1/objects/4527a9019e37e001770787e4523b505f79cac4c5/server.jar

# Switch to the non-root user
USER minecraft

# Set the working directory
WORKDIR /minecraft

# Copy the bootstrap script
COPY ./docker-scripts/bootstrap-server.sh /

# print id/gid
RUN id
RUN echo "User ID: $(id -u minecraft)" && \
    echo "Group ID: $(id -g minecraft)"

EXPOSE 25565

# Set the entrypoint
ENTRYPOINT [ "/bin/bash", "/bootstrap-server.sh" ]