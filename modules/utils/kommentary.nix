{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.kommentary;
in {
  options.vim.utils.kommentary = {
    enable = mkEnableOption "enable kommentary";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "kommentary"
    ];

    vim.luaConfigRC.sql =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("kommentary.config").configure_language("default", {
          prefer_single_line_comments = true,
          use_consistent_indentation = true,
          ignore_whitespace = true,
        })

        vim.keymap.set("v", "<space>c", "<Plug>kommentary_visual_default", { silent = true, noremap = true, desc = "Comment Selected Code" })
        vim.keymap.set("n", "<space>c", "<Plug>kommentary_line_default", { silent = true, noremap = true, desc = "Comment Line" })

      '';
  };
}
