{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil # nix lsp
  ];

  programs.helix = {
    enable = true;
    
    settings = {
      # theme = "catppuccin_macchiato";
      theme = "rose_pine";

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
          # left = ["mode" "spinner" "version-control" "file-name"];
          left = ["mode" "spinner" "file-name" "read-only-indicator" "file-modification-indicator" "version-control"];
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
        # helix-gpt = {
        #   command = "${pkgs.helix-gpt}/bin/helix-gpt";
        #   args = [ "--handler" "codeium" "--triggerCharacters" "\"\"" ];
        # };
      };

      language = [
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "cargo fmt";
          };
          # language-servers = [ "rust-analyzer" "helix-gpt" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "wgsl";
          # language-servers = [ "helix-gpt" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "nix";
          # language-servers = [ "nil" "helix-gpt" ];
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
