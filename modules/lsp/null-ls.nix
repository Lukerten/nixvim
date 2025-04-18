{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
in {
  options.vim.lsp.null-ls = {
    enable = mkEnableOption "null-ls, also enabled automatically";

    sources = mkOption {
      description = "null-ls sources";
      type = with types; attrsOf str;
      default = {};
    };
  };

  config = mkIf cfg.null-ls.enable (mkMerge [
    {
      vim.lsp.enable = true;
      vim.startPlugins = ["null-ls"];

      vim.luaConfigRC.null_ls-setup =
        nvim.dag.entryAnywhere
        # lua
        ''
          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          local null_ls = require("null-ls")
          local null_helpers = require("null-ls.helpers")
          local null_methods = require("null-ls.methods")
          local ls_sources = {}
        '';

      vim.luaConfigRC.null_ls =
        nvim.dag.entryAfter ["null_ls-setup" "lsp-setup"]
        # lua
        ''

          require('null-ls').setup({
            diagnostics_format = "[#{m}] #{s} (#{c})",
            debounce = 250,
            default_timeout = 5000,
            sources = ls_sources,
            on_attach = function(client, bufnr)
              if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format()
                  end,
                })
              end
            end,
          })
        '';
    }
    {
      vim.luaConfigRC = mapAttrs (_: v: (nvim.dag.entryBetween ["null_ls"] ["null_ls-setup"] v)) cfg.null-ls.sources;
    }
  ]);
}
