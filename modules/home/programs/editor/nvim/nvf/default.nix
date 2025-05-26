{
  pkgs,
  lib,
  ...
}:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
        };

        autocmds = [
          {
            enable = true;
            desc = "Set indentation for Nix and Lua";
            event = [ "Filetype" ];
            pattern = [
              "lua"
              "nix"
            ];
            callback = lib.generators.mkLuaInline ''
              function()
                vim.opt_local.tabstop = 2
                vim.opt_local.shiftwidth = 2
                vim.opt_local.softtabstop = 2
              end
            '';
          }
        ];

        autocomplete = {
          nvim-cmp = {
            enable = true;
          };
        };

        autopairs = {
          nvim-autopairs = {
            enable = true;
          };
        };

        clipboard = {
          enable = true;
        };

        comments = {
          comment-nvim = {
            enable = true;
          };
        };

        startPlugins = with pkgs.vimPlugins; [
          vim-tmux-navigator
        ];

        filetree = {
          nvimTree = {
            enable = true;
            setupOpts = {
              git = {
                enable = true;
              };
            };
            mappings = {
              toggle = "<leader>e";
            };
          };
        };

        git = {
          enable = true;
        };

        globals = {
          mapleader = " ";
        };

        keymaps = [
        ];

        languages = {
          enableDAP = true;
          enableTreesitter = true;
          rust.enable = true;
          nix.enable = true;
          clang.enable = true;
          markdown.enable = true;
          lua.enable = true;
          java.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
          };
        };

        telescope = {
          enable = true;
          mappings = {
            findFiles = "<leader>ff";
            gitStatus = "<leader>gst";
            liveGrep = "<leader>fg";
          };
        };

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = true;
        };

        treesitter = {
          enable = true;
          addDefaultGrammars = true;
          autotagHtml = true;
          fold = true;
        };
      };
    };
  };
}
