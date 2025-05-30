FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up
RUN apt update && \
    apt install -y --no-install-recommends \
        curl \
        wget \
        unzip \
        ca-certificates \
        screen \
        openjdk-17-jre && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the server files
RUN wget -q https://github.com/ThePansmith/Monifactory/releases/download/0.12.6/Monifactory-Beta.0.12.6-server.zip && \
    unzip Monifactory-Beta.0.12.6-server.zip -d /minecraft-unzipped && \
    rm Monifactory-Beta.0.12.6-server.zip

# Set the working directory
WORKDIR /minecraft-unzipped

# Download Forge
RUN wget -q https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.3.7/forge-1.20.1-47.3.7-installer.jar

# Run the Forge installer to set up the server
RUN java -jar forge-1.20.1-47.3.7-installer.jar --installServer

# Create a non-root user and set permissions
RUN useradd -m minecraft && \
    mkdir -p /minecraft /minecraft-data && \
    chown -R minecraft:minecraft /minecraft /minecraft-unzipped /minecraft-data

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