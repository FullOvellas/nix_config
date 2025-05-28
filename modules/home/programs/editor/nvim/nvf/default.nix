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
        autocmds = [
          {
            desc = "Set indentation for Nix, Lua, JSON";
            event = [ "Filetype" ];
            pattern = [
              "lua"
              "nix"
              "json"
              "jsonc"
            ];
            callback = lib.generators.mkLuaInline ''
              function()
                vim.opt_local.tabstop = 2
                vim.opt_local.shiftwidth = 2
                vim.opt_local.softtabstop = 2
              end
            '';
            enable = true;
          }
          {
            desc = "Open/close in NvimTree with l/h";
            event = [ "Filetype" ];
            pattern = [ "NvimTree" ];
            callback = lib.generators.mkLuaInline ''
              function(args)
                local api = require("nvim-tree.api")

                local function opts(desc)
                  return {
                    desc = "nvim-tree: " .. desc,
                    buffer = args.buf,
                    noremap = true,
                    silent = true,
                    nowait = true,
                  }
                end

                -- Custom h behavior
                vim.keymap.set("n", "h", function()
                  local node = api.tree.get_node_under_cursor()
                  if not node then return end

                  if node.type == "directory" and node.open then
                    -- Close current folder if open
                    api.node.navigate.parent_close()
                  else
                    -- Otherwise, close parent folder
                    api.node.navigate.parent()
                  end
                end, opts("Close folder or go to parent"))

                -- Custom l behavior
                vim.keymap.set("n", "l", function()
                  local node = api.tree.get_node_under_cursor()
                  if not node then return end

                  if node.type == "directory" then
                    if node.open then
                      -- Move into the directory by selecting its first child
                      vim.cmd("normal! j")
                    else
                      -- Open the folder
                      api.node.open.edit()
                    end
                  else
                    -- Open the file
                    api.node.open.edit()
                  end
                end, opts("Open file or enter directory"))
              end
            '';
            enable = true;
          }
        ];

        autocomplete = {
          nvim-cmp = {
            enable = true;
            format = lib.generators.mkLuaInline ''
              function(entry, vim_item)
                return vim_item
              end
            '';
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

        extraPlugins = with pkgs.vimPlugins; {
          neorg = {
            package = neorg;
            setup = ''
              require("neorg").setup {
                        load = {
                          ["core.defaults"] = {},
                          ["core.concealer"] = {},
                          ["core.dirman"] = {
                            config = {
                              workspaces = {
                                notes = "~/Documents/notes",
                              },
                              default_workspace = "notes",
                            },
                          },
                        },
                      }
              vim.wo.foldlevel = 99
              vim.wo.conceallevel = 2
            '';
          };
          neorg-telescope = {
            package = neorg-telescope;
          };
        };

        startPlugins = with pkgs.vimPlugins; [
          vim-tmux-navigator
          (nvim-treesitter.withPlugins (
            p: with p; [
              tree-sitter-lua
            ]
          ))
        ];

        filetree = {
          nvimTree = {
            enable = true;
            setupOpts = {
              actions = {
                open_file = {
                  eject = true;
                  window_picker = {
                    enable = true;
                  };
                };
              };
              git = {
                enable = true;
              };
              renderer = {
                highlight_git = true;
                icons = {
                  show = {
                    git = true;
                  };
                };
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
          python.enable = true;
        };

        lsp = {
          enable = true;
          lspkind = {
            enable = true;
            setupOpts = {
              mode = "symbol";
            };
          };
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

        ui = {
          borders.plugins.nvim-cmp.enable = true;
        };

        utility = {
          surround.enable = true;
        };

        viAlias = true;
        vimAlias = true;

        visuals = {
          nvim-web-devicons = {
            enable = true;
          };
        };
      };
    };
  };
}
