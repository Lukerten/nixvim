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

    vim.luaConfigRC.kommentary =
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
      '';
  };
}
