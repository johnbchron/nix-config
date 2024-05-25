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

    scribe = {
      url = "github:johnbchron/scribe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, apple-silicon-support, ... }@inputs:
    let
      system = "aarch64-linux";
      hardwarePath = ./hardware/gimli.nix;
    in {
      nixosConfigurations.gimli = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { inherit hardwarePath; };
        modules = [
          ./system.nix
          apple-silicon-support.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jlewis = import ./home/main.nix;
              extraSpecialArgs = inputs;
            };
          }
        ];
      };
  };
}
