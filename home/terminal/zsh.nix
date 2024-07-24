{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = rec {
      e = "exit";
      cleanup-dev = "rm -rf ~/github/*/{.direnv/,result} ~/playground/*/{.direnv/,result}";
      clr = "clear";
      gu = "gitui";
      neofetch = "fastfetch";
      l = "eza --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      ls = "eza";
      q = "exit";
      tree = "eza --tree --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      treeg = tree + " --git-ignore";
      with-rust = "nix develop \"/home/jlewis/github/with-rust\" --command $SHELL";
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

  # nix-shell custom zsh plugin
  home.file.ohmyzsh-nix-shell = let
    nix-shell-repo = pkgs.fetchgit {
      url = "https://github.com/chisui/zsh-nix-shell";
      rev = "82ca15e638cc208e6d8368e34a1625ed75e08f90";
      hash = "sha256-Rtg8kWVLhXRuD2/Ctbtgz9MQCtKZOLpAIdommZhXKdE=";
    };
  in {
    source = "${nix-shell-repo}";
    target = ".config/ohmyzsh_custom/plugins/nix-shell";
  };
}
