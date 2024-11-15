{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.whichKey;
in {
  options.vim.utils.whichKey = {
    enable = mkEnableOption "which-key menu";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = ["which-key"];

    vim.luaConfigRC.whichkey = nvim.dag.entryAnywhere ''local wk = require("which-key").setup {}'';
  };
}
