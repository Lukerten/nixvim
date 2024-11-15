{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.noice;
in {
  options.vim.visual.noice = {
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

  config = mkIf cfg.enable {
    vim.startPlugins = [
      "noice"
      "notify"
    ];
    vim.luaConfigRC.noice =
      nvim.dag.entryAnywhere
      /*
      lua
      */
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
            bottom_search = ${boolToString cfg.presets.bottomSearch},
            command_palette = ${boolToString cfg.presets.commandPalette},
            inc_rename = ${boolToString cfg.presets.incRename},
            long_message_to_split = ${boolToString cfg.presets.longMessageToSplit},
            lsp_doc_border = ${boolToString cfg.presets.lspDocBorder},
          },
        })

        require("notify").setup({
          background_colour = "#00000000"
        })
      '';
  };
}
