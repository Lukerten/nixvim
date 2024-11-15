{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.luatab;
in {
  options.vim.visual.luatab = {
    enable = mkEnableOption "Luatab [luatab]";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["luatab"];
    vim.luaConfigRC.luatab =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("luatab").setup{}
      '';
  };
}
