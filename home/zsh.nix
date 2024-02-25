{ pkgs, helix-fork, ... }: {
  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = {
      e = "exit";
      clr = "clear";
      snorbs = "sudo nixos-rebuild switch --flake '/home/jlewis/nix-config#' --impure";
      treeg = "tree --gitignore";
      nd = "nix develop --command $SHELL";
      ls = "eza";
      l = "eza -alh";
      with-rust = "nix develop \"/home/jlewis/github/with-rust\" --command $SHELL";
    };
    sessionVariables = {
      "VISUAL" = "${helix-fork.packages.aarch64-linux.default}/bin/hx";
      "EDITOR" = "${helix-fork.packages.aarch64-linux.default}/bin/hx";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "nix-shell" ];
      custom = "/home/jlewis/.config/ohmyzsh_custom";
    };
    
    syntaxHighlighting = {
      enable = true;
    };
  };
}
