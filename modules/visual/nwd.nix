{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.nvimWebDevicons;
in {
  options.vim.visual.nvimWebDevicons = {
    enable = mkEnableOption "Dev icons. Required for certain plugins [nvim-web-devicons].";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["nvim-web-devicons"];
  };
}
