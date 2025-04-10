{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.theme;
  transparent = config.vim.transparentBackground;
in {
  options.vim.theme = {
    enable = mkEnableOption "Theme configuration.";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["theme"];

    vim.luaConfigRC.theme =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("catppuccin").setup({
          flavour = "auto", -- latte, frappe, macchiato, mocha
          -- use Inherited Transparent Background
          transparent_background = ${toString transparent},
          background = { -- :h background
            light = "latte",
            dark = "mocha",
          }
        })

        vim.cmd("colorscheme catppuccin")
      '';
  };
}
