{ ... }: {
  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = {
      e = "exit";
      clr = "clear";
      snorbs = "sudo nixos-rebuild switch --flake '/home/jlewis/nix-config#' --impure";
      treeg = "tree --gitignore";
      ls = "eza";
      l = "eza -alh";
      with-rust = "nix develop \"/home/jlewis/github/with-rust\" --command $SHELL";
      cleanup-dev = "rm -rf ~/github/*/{.direnv/,result} ~/playground/*/{.direnv/,result}";
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
