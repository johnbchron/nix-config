
rebuild-switch:
    sudo nixos-rebuild switch --flake .#

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

vm:
    nixos-rebuild build-vm --flake .#generic
    ./result/bin/run-nixos-vm

vm-graphical:
    nixos-rebuild build-vm --flake .#generic-graphical
    ./result/bin/run-nixos-vm


update-grammars:
    nix shell nixpkgs#clang -c sh -c "hx --grammar fetch && hx --grammar build"
