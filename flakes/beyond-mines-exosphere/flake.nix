    {
      inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        arion = {
          url = "github:hercules-ci/arion";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };
      outputs = { self, nixpkgs, arion, ... }: {
        nixosConfigurations."nixos-white-dragon" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            arion.nixosModules.arion
            ({ config, pkgs, ... }: {
              virtualisation.docker.enable = true;
              users.users."melty".extraGroups = [ "docker" ];
              arion.projects."minecraft-beyond-mines-exosphere".composeFile = /home/melty/Git/minecraft-docker/beyond-mines-exosphere/docker-compose.yml;
            })
          ];
        };
      };
    }
