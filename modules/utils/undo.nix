{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.undo;
in {
  options.vim.utils.undo = {
    enable = mkEnableOption "enable undotree";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "undotree"
    ];

    vim.luaConfigRC.undo =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require('undotree').setup()
        vim.api.nvim_set_keymap('n', '<leader>u', ':lua require("undotree").toggle()<CR>', {noremap = true, silent = true, desc = "Toggle undotree"})
      '';
  };
}
