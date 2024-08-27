{ pkgs, helix-fork, ... }: let
  copilot-wrapped = pkgs.writeShellScriptBin "copilot" ''
    ${pkgs.nodejs}/bin/node ${pkgs.vimPlugins.copilot-vim}/dist/language-server.js $@
  '';
in {
  home.packages = with pkgs; [
    nil # nix lsp
    copilot-wrapped
  ];

  # launches helix mode with the copilot lsp appended
  # this is also why we don't explicitly configure the copilot lsp
  programs.zsh.shellAliases.hx = "hx -a";

  programs.helix = {
    enable = true;
    package = helix-fork.packages.aarch64-linux.default;
    
    settings = {
      theme = "kanagawa";
      # theme = "everforest_dark";
      # theme = "catppuccin_mocha";
      # theme = "rose_pine";

      editor = {
        line-number = "relative";
        mouse = true;
        rulers = [ 80 ];
        bufferline = "always";
        cursorline = true;
        # cursorcolumn = true;
        color-modes = true;
        idle-timeout = 200;
        text-width = 80;
      
        statusline = {
          left = [
            "mode" "spinner" "file-name" "read-only-indicator"
            "file-modification-indicator" "version-control"
          ];
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        auto-pairs = {
          "<" = ">";
        };

        soft-wrap = {
          enable = true;
          # wrap-at-text-width = true;
        };
      };

      keys.insert = {
        "S-tab" = "unindent";
        "C-y" = "copilot_apply_completion";
      };

      keys.normal = {
        "q" = ":quit-all";
      };
      keys.select = {
        "q" = ":quit-all";
      };
    };

    languages = {
      language-server = {
        rust-analyzer = {
          config = {
            assist.termSearch.fuel = 1800;
            check.command = "clippy";
            completion.termSearch.enable = true;
            diagnostics.experimental.enable = true;
            hover.memoryLayout.niches = true;
            hover.show.traitAssocItems = 3;
            inlayHints.closureCaptureHints.enable = true;
          };
        };
      };

      language = [
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "cargo fmt";
          };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "wgsl";
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "surrealdb";
          scope = "source.surrealdb";
          file-types = [ "surql" ];
          comment-tokens = "--";
          indent = { tab-width = 2; unit = "  "; };
          grammar = "surrealdb";
        }
      ];

      # note: in order for this grammar to work, run the following:
      # `nix shell nixpkgs#clang -c sh -c "hx --grammar fetch && hx --grammar build"`
      # it may take some moments to fetch the first time
      grammar = [
        {
          name = "surrealdb";
          source = {
            git = "https://github.com/DariusCorvus/tree-sitter-surrealdb";
            rev = "17a7ed4481bdaaa35a1372f3a94bc851d634a19e";
          };
        }
      ];
    };
  };

  
  home.file.surql-queries = let
    surql-ts-src = pkgs.fetchgit {
      url = "https://github.com/DariusCorvus/tree-sitter-surrealdb";
      rev = "17a7ed4481bdaaa35a1372f3a94bc851d634a19e";
      hash = "sha256-/xX5lEQKFuLQl6YxUA2WLKGX5P2GBugtYj42WCtA0xU=";
    };
  in {
    source = "${surql-ts-src}/queries/highlights.scm";
    target = ".config/helix/runtime/queries/surrealdb/highlights.scm";
  };
}
