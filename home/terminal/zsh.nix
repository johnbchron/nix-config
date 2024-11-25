{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    history.size = 3000;
    shellAliases = let
      tree = "eza --tree --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      zellij-project-env = pkgs.writeShellScript "zellij-project-env" ''
        SESSION_NAME=$(zellij list-sessions -r -s | head -n 1)
        PROJECT_NAME=$1
        
        zellij \
          --session $SESSION_NAME \
          action new-tab \
            --layout compact \
            --cwd ~/github/$PROJECT_NAME \
            --name $PROJECT_NAME
        zellij \
          --session $SESSION_NAME \
          action write-chars 'hx''\n'
        zellij \
          --session $SESSION_NAME \
          action new-pane \
            --direction right \
            --cwd ~/github/$PROJECT_NAME \
            --close-on-exit \
            -- zsh
        zellij \
          --session $SESSION_NAME \
          action focus-previous-pane
      '';
    in {
      cg = "cd $(git rev-parse --show-toplevel)";
      cleanup-dev = "rm -rf ~/github/*/{.direnv/,result} ~/playground/*/{.direnv/,result}";
      clr = "clear";
      daily = "command hx \"~/obsidian/main/Daily Notes/$(date +'%Y-%m-%d').md\"";
      e = "exit";
      gu = "gitui";
      neofetch = "fastfetch";
      l = "eza --all --long --header --total-size --git --git-repos --mounts --hyperlink";
      ls = "eza";
      pe = "${zellij-project-env}";
      q = "exit";
      speed = "cfspeedtest";
      inherit tree;
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
