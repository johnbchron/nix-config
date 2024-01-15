{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-fork = {
      url = "github:AlexanderDickie/helix/copilot";
    };
    copilot-wrapped = {
      url = "./copilot-wrapped";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, apple-silicon-support, ... }@inputs:
    let
      system = "aarch64-linux";
    in {
      nixosConfigurations.gimli = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { hardwarePath = ./hardware/gimli.nix; };
        modules = [
          ./system.nix
          apple-silicon-support.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jlewis = import ./home.nix;
              extraSpecialArgs = inputs;
            };
          }
        ];
      };
  };
}
