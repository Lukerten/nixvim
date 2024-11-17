{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
in {
  options.vim.lsp = {
    trouble = {
      enable = mkEnableOption "trouble diagnostics viewer";
    };
  };

  config = mkIf (cfg.enable && cfg.trouble.enable) {
    vim.startPlugins = ["trouble"];

    vim.nnoremap = {
      "<leader>Xx" = "<cmd>Trouble diagnostics toggle<CR>";
      "<leader>XX" = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
      "<leader>Xt" = "<cmd>Trouble todo<CR>";
      "<leader>Xs" = "<cmd>Trouble symbols toggle focus=false<CR>";
      "<leader>Xl" = "<cmd>Trouble lsp toggle focus=false win.position=right<CR>";
      "<leader>XL" = "<cmd>Trouble loclist toggle<CR>";
      "<leader>XQ" = "<cmd>Trouble qflist toggle<CR>";
    };

    vim.luaConfigRC.trouble =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        -- Enable trouble diagnostics viewer
        require("trouble").setup {}
      '';
  };
}
