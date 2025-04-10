{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.theme;
in {
  options.vim.theme = {
    enable = mkEnableOption "Theme configuration.";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = ["theme"];

    vim.luaConfigRC.theme =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("catppuccin").setup{}
        vim.cmd("colorscheme catppuccin")
      '';
  };
}
