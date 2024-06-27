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
  };

  outputs = { self, nixpkgs, home-manager, apple-silicon-support, niri, ... }@inputs: {
    nixosConfigurations.gimli = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = inputs;
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
            extraSpecialArgs = inputs;
          };
        }
      ];
    };

    nixosConfigurations.bumble = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
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
            extraSpecialArgs = inputs;
          };
        }
      ];
    };
  };
}
