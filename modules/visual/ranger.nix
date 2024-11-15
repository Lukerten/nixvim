{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.vim.visual.ranger;
in
{
  options.vim.visual.ranger = {
    enable = mkEnableOption "Ranger filetree [ranger]";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["ranger"];
    vim.luaConfigRC.ranger =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("ranger-nvim").setup({ replace_netrw = true })
        vim.api.nvim_set_keymap("n", "<leader>ef", "", {
          noremap = true,
          callback = function()
            require("ranger-nvim").open(true)
          end,
        })
      '';
  };
}
