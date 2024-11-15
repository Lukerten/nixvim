{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.autopairs;
in {
  options.vim.visual.autopairs = {
    enable = mkEnableOption "auto pairs [nvim-autopairs]";
    type = mkOption {
      type = types.enum ["nvim-autopairs"];
      default = "nvim-autopairs";
      description = "Set the autopairs type. Options: nvim-autopairs [nvim-autopairs]";
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["nvim-autopairs"];
    vim.luaConfigRC.autopairs =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("nvim-autopairs").setup{}
      '';
  };
}
