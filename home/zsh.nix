{ ... }: {
  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = {
      e = "exit";
      clr = "clear";
      treeg = "eza --tree --all --long --header --total-size --git --git-repos --git-ignore --mounts --hyperlink";
      l = "eza --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      ls = "eza";
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
