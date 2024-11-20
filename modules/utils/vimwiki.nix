{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.vimwiki;
in {
  options.vim.utils.vimwiki = {
    enable = mkEnableOption "enable vimwiki";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "vimwiki"
    ];

    vim.luaConfigRC.vimwiki =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        vim.g.vimwiki_list = {{
          path = '~/Documents/notes',
          syntax = 'markdown',
          ext = 'md',
          diary_rel_path = 'private/Diary'
        }}
        vim.api.nvim_set_keymap("n", "<leader>w", ":VimwikiIndex<CR>", { noremap = true, silent = true, desc = "Open Vimwiki" })

      '';
  };
}
