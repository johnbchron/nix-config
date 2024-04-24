
rebuild-switch:
    sudo nixos-rebuild switch --flake '/home/jlewis/nix-config#' --impure

expire-home-manager:
    nix shell nixpkgs#home-manager -c home-manager expire-generations "-2 minutes"

clean: expire-home-manager
    sudo nix-collect-garbage -d
