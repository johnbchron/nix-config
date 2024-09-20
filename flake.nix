{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-fork = {
      url = "github:AlexanderDickie/helix/copilot";
    };

    scribe = {
      url = "github:johnbchron/scribe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tikv-explorer.url = "github:johnbchron/tikv-explorer";
  };

  outputs = { nixpkgs, apple-silicon-support, home-manager, ... } @ inputs: let
    hm-as-nixos-module = { modules, system }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.jlewis = { ... }: { imports = modules; };
        extraSpecialArgs = inputs // { inherit system inputs; };
      };
    };
  in {
    nixosConfigurations.gimli = nixpkgs.lib.nixosSystem (let
      system = "aarch64-linux";
    in {
      inherit system;
      specialArgs = inputs // { inherit system inputs; };
      modules = [
        ./system/main.nix
        ./system/graphical.nix
        ./hosts/gimli/system.nix
        apple-silicon-support.nixosModules.default
        home-manager.nixosModules.home-manager
        (hm-as-nixos-module {
          modules = [
            ./home/main.nix
            ./home/terminal.nix
            ./home/graphical.nix
          ];
          inherit system;
        })
      ];
    });

    nixosConfigurations.generic = nixpkgs.lib.nixosSystem (let
      system = "aarch64-linux";
    in {
      inherit system;
      specialArgs = inputs // { inherit system inputs; };
      modules = [
        ./system/main.nix
        ./system/graphical.nix
        home-manager.nixosModules.home-manager
        (hm-as-nixos-module {
          modules = [
            ./home/main.nix
            ./home/terminal.nix
            ./home/graphical.nix
          ];
          inherit system;
        })
      ];
    });
  };
}
