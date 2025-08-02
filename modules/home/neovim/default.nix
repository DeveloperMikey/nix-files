{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        extraPackages = with pkgs; [
          kdePackages.qtdeclarative
        ];

        options = {
          shiftwidth = 4;
          tabstop = 4;
          exrc = true;
        };

        extraPlugins = {
          smear-cursor = {
            package = pkgs.vimPlugins.smear-cursor-nvim;
            setup = ''
              require('smear_cursor').enabled = true
            '';
          };
          neoscroll = {
            package = pkgs.vimPlugins.neoscroll-nvim;
            setup = ''
              require('neoscroll').setup({})
            '';
          };
        };

        luaConfigRC = {
          lspconfig = ''
            require("lspconfig").qmlls.setup {
              cmd = {"qmlls"}
            }
          '';
          exrc = ''
            vim.o.exrc = true
          '';
        };

        keymaps = [
          {
            key = "-";
            mode = "n";
            action = "<CMD>Oil<CR>";
            silent = true;
            desc = "Open parent directory in Oil";
          }
        ];

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspconfig = {
            enable = true;
          };
          trouble.enable = true;
          lightbulb.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        languages = {
          enableFormat = true;
          enableExtraDiagnostics = true;

          nix = {
            enable = true;
            lsp.server = "nil";
            treesitter.enable = true;
          };

          lua = {
            enable = true;
            lsp.lazydev.enable = true;
            treesitter.enable = true;
          };

          rust = {
            enable = true;
            crates.enable = true;
            lsp.package = ["rust-analyzer"];
          };
        };

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          #mappings.confirm = "<C-CR>";
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;

        statusline = {
          lualine = {
            enable = true;
            theme = "gruvbox";
          };
        };

        snippets.luasnip.enable = true;

        tabline = {
          nvimBufferline = {
            enable = true;
            mappings = {
              closeCurrent = "<leader>cc";
              cycleNext = "<leader>ll";
              cyclePrevious = "<leader>hh";
              moveNext = "<leader>kk";
              movePrevious = "<leader>jj";
            };
            setupOpts = {
              options = {
                always_show_bufferline = false;
                name_formatter = lib.generators.mkLuaInline (builtins.readFile ./bufferline_name_formatter.lua);
              };
            };
          };
        };

        utility = {
          oil-nvim.enable = true;
          oil-nvim.setupOpts = {
            view_options = {
              show_hidden = true;
            };
          };
        };

        #treesitter.context.enable = true;
        treesitter = {
          enable = true;
          indent.enable = false;
          grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            qmljs
          ];
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };

        utility = {
          diffview-nvim.enable = true;
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
          };
        };

        session = {
          nvim-session-manager = {
            enable = true;
            setupOpts.autoload_mode = "GitSession";
          };
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
          hardtime-nvim.enable = true;
        };

        diagnostics = {
          enable = true;
          config = {
            virtual_text = true;
          };
          nvim-lint.enable = true;
        };

        notify.nvim-notify.enable = true;
        projects.project-nvim.enable = true;
        dashboard.alpha.enable = true;
        telescope.enable = true;
      };
    };
  };
}
