{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    iosevka-pin.url = "github:NixOS/nixpkgs?rev=f675531bc7e6657c10a18b565cfebd8aa9e24c14";

    apple-silicon-support = {
      url = "github:nix-community/nixos-apple-silicon";
      # url = "github:kitten/nixos-apple-silicon/edge";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alacritty-theme = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

    jj-watch.url = "github:johnbchron/jj-watch";
  };

  outputs = { nixpkgs, apple-silicon-support, home-manager, ... } @ inputs: let
    # function to produce a nixos module from hm modules
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
        home-manager.nixosModules.home-manager
        (hm-as-nixos-module {
          modules = [
            ./home/main.nix
            ./home/terminal.nix
          ];
          inherit system;
        })
      ];
    });

    nixosConfigurations.generic-graphical = nixpkgs.lib.nixosSystem (let
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
