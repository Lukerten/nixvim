{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.vim.visual.indentBlankline;
in
{
  options.vim.visual.indentBlankline = {
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
        Displays the end of line character set by <<opt-vim.visual.indentBlankline.eolChar>> instead of the
        indent guide on line returns.
      '';
      type = types.bool;
      default = cfg.eolChar != null;
      defaultText = literalExpression "config.vim.visual.indentBlankline.eolChar != null";
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

  config = mkIf cfg.enable {
    vim.startPlugins = ["indent-blankline"];
    vim.luaConfigRC.indent-blankline =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        vim.opt.list = true
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)
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
  };
}
