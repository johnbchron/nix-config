{ pkgs, ... }: {
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
        color-modes = true;
        idle-timeout = 200;
        text-width = 80;
      
        statusline = {
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          # inline-diagnostics = {
          #   enabled = true;
          # };
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
        # "C-y" = "apply_copilot_completion";
      };

      keys.normal = {
        "q" = ":quit-all";
      };
    };

    languages = {
      language-server = {
        helix-gpt = {
          command = "${pkgs.helix-gpt}/bin/helix-gpt";
          args = [ "--handler" "codeium" "--triggerCharacters" "\"\"" ];
        };
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
      ];
    };
  };
}
