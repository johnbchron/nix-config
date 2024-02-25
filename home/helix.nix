{ helix-fork, copilot-wrapped, ... }: {
  programs.helix = {
    enable = true;
    package = helix-fork.packages.aarch64-linux.default;
    
    settings = {
      theme = "catppuccin_macchiato";

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
          wrap-at-text-width = true;
        };
      };

      keys.insert = {
        "S-tab" = "unindent";
        "C-y" = "apply_copilot_completion";
      };

      keys.normal = {
        "q" = ":quit-all";
      };
    };

    languages = {
      language-server = {
        copilot = {
          command = "${copilot-wrapped.packages.aarch64-linux.default}/bin/copilot";
          args = [ "--stdio" ];
        };
      };

      language = [
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "cargo fmt";
          };
          language-servers = [ "rust-analyzer" "copilot" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "javascript";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "typescript";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "jsx";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "tsx";
          language-servers = [ "typescript-language-server" "copilot" ];
        }
        {
          name = "wgsl";
          language-servers = [ "copilot" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "nix";
          language-servers = [ "nil" "copilot" ];
        }
      ];
    };
  };
}
