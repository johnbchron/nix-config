{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.jlewis-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs // { hardwarePath = ./hardware/jlewis-laptop.nix; };
      modules = [ ./configuration.nix ];
    };
  };
}
