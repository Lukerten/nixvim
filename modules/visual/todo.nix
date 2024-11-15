{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.todo;
in {
  options.vim.visual.todo = {
    enable = mkEnableOption "Todo highlights [nvim-todo]";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["todo"];
    vim.luaConfigRC.todo =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("todo-comments").setup{}
      '';
  };
}
