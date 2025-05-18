FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up
RUN apt update && \
    apt install -y --no-install-recommends \
        curl \
        wget \
        unzip \
        openjdk-17-jre && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the server files
RUN wget -q https://mediafilez.forgecdn.net/files/6487/661/BM_Exosphere_2.0.2_server.zip && \
    unzip BM_Exosphere_2.0.2_server.zip -d /minecraft-unzipped && \
    rm BM_Exosphere_2.0.2_server.zip

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