    {
      inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        arion = {
          url = "github:hercules-ci/arion";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };
      outputs = { self, nixpkgs, arion, ... }: {
        nixosConfigurations.your-machine-name = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            arion.nixosModules.arion
            ({ config, pkgs, ... }: {
              virtualisation.docker.enable = true;
              users.users.yourusername.extraGroups = [ "docker" ];
              arion.projects."your-docker-compose-app".composeFile = /path/to/your/docker-compose.yml;
            })
          ];
        };
      };
    }
