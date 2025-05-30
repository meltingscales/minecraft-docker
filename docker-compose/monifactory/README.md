## Starting the server

    docker compose up -d

## Getting a shell

You can enable rcon. It's been impossible to reattach to stdin, so I'm pivoting.

Note that rcon is NOT ENCRYPTED so please do not expose this to the internet.

1. Edit `server.properties` thusly and reboot the server

    ```properties
    enable-rcon=true
    rcon.port=25575
    rcon.password=your_secure_password
    ```

2. Install a CLI rcon tool:

        https://github.com/radj307/ARRCON

3. Connect!

        ARRCON --host 127.0.0.1 --port 25575 --password your_secure_password