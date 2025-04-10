{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.visuals;
in {
  options.vim.visuals = {
    enable = mkEnableOption "visual enhancements.";

    autopairs = {
      enable = mkEnableOption "auto pairs [nvim-autopairs]";

      type = mkOption {
        type = types.enum ["nvim-autopairs"];
        default = "nvim-autopairs";
        description = "Set the autopairs type. Options: nvim-autopairs [nvim-autopairs]";
      };
    };

    indentBlankline = {
      enable = mkEnableOption "indentation guides [indent-blankline].";

      listChar = mkOption {
        description = "Character for indentation line.";
        type = types.str;
        default = "│";
      };

      fillChar = mkOption {
        description = "Character to fill indents";
        type = with types; nullOr types.str;
        default = "⋅";
      };

      eolChar = mkOption {
        description = "Character at end of line";
        type = with types; nullOr types.str;
        default = "↴";
      };

      showEndOfLine = mkOption {
        description = nvim.nmd.asciiDoc ''
          Displays the end of line character set by <<opt-vim.visuals.indentBlankline.eolChar>> instead of the
          indent guide on line returns.
        '';
        type = types.bool;
        default = cfg.indentBlankline.eolChar != null;
        defaultText = literalExpression "config.vim.visuals.indentBlankline.eolChar != null";
      };

      showCurrContext = mkOption {
        description = "Highlight current context from treesitter";
        type = types.bool;
        default = config.vim.treesitter.enable;
        defaultText = literalExpression "config.vim.treesitter.enable";
      };

      useTreesitter = mkOption {
        description = "Use treesitter to calculate indentation when possible.";
        type = types.bool;
        default = config.vim.treesitter.enable;
        defaultText = literalExpression "config.vim.treesitter.enable";
      };
    };

    leap.enable = mkEnableOption "Leap motion support [leap]";
    lualine = {
      enable = mkEnableOption "lualine statusline.";
      icons = mkOption {
        description = "Enable icons for lualine";
        type = types.bool;
        default = true;
      };

      disabledFiletypes = mkOption {
        description = "Filetypes to disable lualine";
        type = with types; listOf types.str;
        default = [
          "dashboard"
          "NvimTree"
          "Outline"
          "alpha"
          "Trouble"
        ];
      };

      theme = mkOption {
        description = "Theme for lualine";
        type = types.str;
        default = "auto";
        defaultText = ''`config.vim.theme.name` if theme supports lualine else "auto"'';
      };

      sectionSeparator = {
        left = mkOption {
          description = "Section separator for left side";
          type = types.str;
          default = "";
        };

        right = mkOption {
          description = "Section separator for right side";
          type = types.str;
          default = "";
        };
      };

      componentSeparator = {
        left = mkOption {
          description = "Component separator for left side";
          type = types.str;
          default = "⏽";
        };

        right = mkOption {
          description = "Component separator for right side";
          type = types.str;
          default = "⏽";
        };
      };

      activeSection = {
        a = mkOption {
          description = "active config for: | (A) | B | C       X | Y | Z |";
          type = types.str;
          default =
            #lua
            ''
              {'mode'}
            '';
        };

        b = mkOption {
          description = "active config for: | A | (B) | C       X | Y | Z |";
          type = types.str;
          default =
            # lua
            ''
              {
                "branch",
                "diff",
              }
            '';
        };

        c = mkOption {
          description = "active config for: | A | B | (C)       X | Y | Z |";
          type = types.str;
          default =
            #lua
            ''{'filename'}'';
        };

        x = mkOption {
          description = "active config for: | A | B | C       (X) | Y | Z |";
          type = types.str;
          default =
            # lua
            ''
              {
                {
                  "diagnostics",
                  sources = {'nvim_lsp'},
                  separator = '',
                  symbols = {
                    error = '',
                    warn = '',
                    info = '',
                    hint = ''
                  },
                },
                "filetype",
              }
            '';
        };

        y = mkOption {
          description = "active config for: | A | B | C       X | (Y) | Z |";
          type = types.str;
          default =
            #lua
            ''
              {'progress'}
            '';
        };

        z = mkOption {
          description = "active config for: | A | B | C       X | Y | (Z) |";
          type = types.str;
          default = "{'location'}";
        };
      };

      inactiveSection = {
        a = mkOption {
          description = "inactive config for: | (A) | B | C       X | Y | Z |";
          type = types.str;
          default = "{}";
        };

        b = mkOption {
          description = "inactive config for: | A | (B) | C       X | Y | Z |";
          type = types.str;
          default = "{}";
        };

        c = mkOption {
          description = "inactive config for: | A | B | (C)       X | Y | Z |";
          type = types.str;
          default = "{'filename'}";
        };

        x = mkOption {
          description = "inactive config for: | A | B | C       (X) | Y | Z |";
          type = types.str;
          default = "{'location'}";
        };

        y = mkOption {
          description = "inactive config for: | A | B | C       X | (Y) | Z |";
          type = types.str;
          default = "{}";
        };

        z = mkOption {
          description = "inactive config for: | A | B | C       X | Y | (Z) |";
          type = types.str;
          default = "{}";
        };
      };
    };

    noice = {
      enable = mkEnableOption "Noice configuration.";

      presets = {
        bottomSearch = mkOption {
          default = true;
          description = "Use a classic bottom cmdline for search";
          type = types.bool;
        };

        commandPalette = mkOption {
          default = true;
          description = "Position the cmdline and popupmenu together";
          type = types.bool;
        };

        incRename = mkOption {
          default = false;
          description = "Enables an input dialog for inc-rename.nvim";
          type = types.bool;
        };

        longMessageToSplit = mkOption {
          default = true;
          description = "Long messages will be sent to a split";
          type = types.bool;
        };

        lspDocBorder = mkOption {
          default = false;
          description = "Add a border to hover docs and signature help";
          type = types.bool;
        };
      };
    };

    nvimWebDevicons.enable = mkEnableOption "dev icons. Required for certain plugins [nvim-web-devicons].";
    ranger.enable = mkEnableOption "Ranger filetree [ranger]";
    todo.enable = mkEnableOption "Todo highlights [nvim-todo]";
    alpha.enable = mkEnableOption "Start and Home Menu";
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.autopairs.enable {
      vim.startPlugins = ["nvim-autopairs"];
      vim.luaConfigRC.autopairs =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("nvim-autopairs").setup{}
        '';
    })

    (mkIf cfg.indentBlankline.enable {
      vim.startPlugins = ["indent-blankline"];
      vim.luaConfigRC.indent-blankline =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("ibl").setup {
            indent = {
              char = "▏",
              tab_char = ".",
            },
            whitespace = {
              highlight = highlight,
              remove_blankline_trail = false,
            },
            scope = {
              show_start = false,
              show_end = false,
            },
          }
        '';
    })
    (mkIf cfg.leap.enable {
      vim.startPlugins = ["leap"];
      vim.luaConfigRC.leap =
        nvim.dag.entryAnywhere
        # lua
        ''
          require('leap').create_default_mappings()
        '';
    })
    (mkIf cfg.lualine.enable {
      vim.startPlugins = ["lualine"];
      vim.luaConfigRC.lualine =
        nvim.dag.entryAnywhere
        # lua
        ''
          require'lualine'.setup {
            options = {
              icons_enabled = ${boolToString cfg.lualine.icons},
              theme = "${toString cfg.lualine.theme}",
              disabled_filetypes = { ${concatStringsSep ", " (map (x: ''"${x}"'') cfg.lualine.disabledFiletypes)} },
              component_separators = {
                left = "${cfg.lualine.componentSeparator.left}",
                right = "${cfg.lualine.componentSeparator.right}"
              },
              section_separators = {
                left = "${cfg.lualine.sectionSeparator.left}",
                right = "${cfg.lualine.sectionSeparator.right}"
              },
            },
            sections = {
              lualine_a = ${cfg.lualine.activeSection.a},
              lualine_b = ${cfg.lualine.activeSection.b},
              lualine_c = ${cfg.lualine.activeSection.c},
              lualine_x = ${cfg.lualine.activeSection.x},
              lualine_y = ${cfg.lualine.activeSection.y},
              lualine_z = ${cfg.lualine.activeSection.z},
            },
            inactive_sections = {
              lualine_a = ${cfg.lualine.inactiveSection.a},
              lualine_b = ${cfg.lualine.inactiveSection.b},
              lualine_c = ${cfg.lualine.inactiveSection.c},
              lualine_x = ${cfg.lualine.inactiveSection.x},
              lualine_y = ${cfg.lualine.inactiveSection.y},
              lualine_z = ${cfg.lualine.inactiveSection.z},
            },
            tabline = {},
            extensions = {},
          }
        '';
    })
    (mkIf cfg.noice.enable {
      vim.startPlugins = [
        "noice"
        "notify"
      ];
      vim.luaConfigRC.noice =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("noice").setup({
            lsp = {
              progress = {
                enabled = false,
              },
              override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
              },
              signature = {
                enabled = false,
              },
              message = {
                enabled = false,
              },
            },
            presets = {
              bottom_search = ${boolToString cfg.noice.presets.bottomSearch},
              command_palette = ${boolToString cfg.noice.presets.commandPalette},
              inc_rename = ${boolToString cfg.noice.presets.incRename},
              long_message_to_split = ${boolToString cfg.noice.presets.longMessageToSplit},
              lsp_doc_border = ${boolToString cfg.noice.presets.lspDocBorder},
            },
          })
          require("notify").setup({
            background_colour = "#00000000",
            stages = "fade_in_slide_out",
            render = "compact",
            timeout = 3000,
            minimum_width = 50,
            icons = { ERROR = "", WARN = "", INFO = "", DEBUG = "", TRACE = "✎" },
            fps = 20,
            on_open = function(win)
              vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
          })
        '';
    })
    (mkIf cfg.nvimWebDevicons.enable {
      vim.startPlugins = ["nvim-web-devicons"];
    })
    (mkIf cfg.ranger.enable {
      vim.startPlugins = ["ranger"];
      vim.luaConfigRC.ranger =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("ranger-nvim").setup({ replace_netrw = true })

          -- vim.api.nvim_set_keymap("n", "<leader>ef", "", {
          --     noremap = true,
          --     callback = function()
          --       require("ranger-nvim").open(true)
          --     end,
          -- })
        '';
    })
    (mkIf cfg.todo.enable {
      vim.startPlugins = ["todo"];
      vim.luaConfigRC.todo =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("todo-comments").setup{}
        '';
    })
    (mkIf cfg.alpha.enable {
      vim.startPlugins = ["alpha"];
      vim.luaConfigRC.alpha =
        nvim.dag.entryAnywhere
        # lua
        ''
          local alpha = require("alpha")
          local dashboard = require("alpha.themes.dashboard")

          dashboard.section.header.val = {
            "                                   ",
            "                                   ",
            "                                   ",
            "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
            "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
            "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
            "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
            "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
            "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
            "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
            " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
            " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
            "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
            "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
            "                                   ",
          }
          dashboard.section.header.opts.hl = "Title"

          dashboard.section.buttons.val = {
            dashboard.button( "e", "  New file"            , ":enew <CR>"),
            dashboard.button( "p", "  Find project"        , ":Telescope projects <CR>"),
            dashboard.button( "f", "  Find files"          , ":Telescope find_files <CR>"),
            dashboard.button( "F", "󱎸  Find text"           , ":Telescope live_grep <CR>"),
          }

          dashboard.section.footer.val = {
            " ",
          }

          alpha.setup(dashboard.opts)
        '';
    })
    (mkIf cfg.todo.enable {
      vim.startPlugins = ["todo"];
      vim.luaConfigRC.todo =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("todo-comments").setup{}
        '';
    })
  ]);
}
