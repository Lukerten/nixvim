{
  lib,
  config,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.lazygit;
in {
  options.vim.utils.lazygit = {
    enable = mkOption {
      type = types.bool;
      description = "enable git plugin: [lazygit]";
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["lazygit"];

    vim.luaConfigRC.lazygit = nvim.dag.entryAnywhere ''
      vim.api.nvim_set_keymap('n', '<leader>/', ':LazyGit<CR>', { silent = true })
    '';
  };
}
