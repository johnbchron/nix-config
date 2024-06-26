
rebuild-switch:
    sudo nixos-rebuild switch --flake '/home/jlewis/nix-config#' --impure

update:
    nix flake update

clean-home-manager:
    nix run nixpkgs#home-manager -- expire-generations "-2 minutes"

clean-nix-tmp-builds:
    sudo rm -rf /tmp/nix-build-*

clean-nix-store:
    sudo nix-collect-garbage -d

clean-docker:
    sudo docker system prune -a -f

clean:
    just clean-home-manager
    just clean-nix-tmp-builds
    just clean-nix-store
    just clean-docker
