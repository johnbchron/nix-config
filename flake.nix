{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs?rev=8035fade6020ea4e7a35efe7a77617390fdfa879";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scribe = {
      url = "github:johnbchron/scribe";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, apple-silicon-support, niri, nixos-generators, ... }@inputs: 
    let
      bumble-modules = [
        ({ modulesPath, ... }:
          { imports = [ "${modulesPath}/virtualisation/amazon-image.nix" ]; })
        ./system/main.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jlewis = { ... }: { imports = [
              ./home/main.nix
              ./home/terminal.nix
            ]; };
            extraSpecialArgs = inputs // { system = "x86_64-linux"; };
          };
        }
      ];
    in {
      nixosConfigurations.gimli = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        specialArgs = inputs // { inherit system; };
        modules = [
          ./system/main.nix
          ./system/graphical.nix
          ./hosts/gimli/system.nix
          apple-silicon-support.nixosModules.default
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jlewis = { ... }: { imports = [
                ./home/main.nix
                ./home/terminal.nix
                ./home/graphical.nix
              ]; };
              extraSpecialArgs = inputs // { inherit system; };
            };
          }
        ];
      };

      nixosConfigurations.bumble = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = bumble-modules;
      };
      packages.x86_64-linux.bumble = nixos-generators.nixosGenerate rec {
        system = "x86_64-linux";
        specialArgs = inputs // {
          inherit system;
          diskSize = 16 * 1024;
        };
        modules = [
          ({ ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
        ] ++ bumble-modules;
      };
  };
}
