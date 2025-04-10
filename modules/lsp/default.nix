{ config
, lib
, ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
  usingNvimCmp = config.vim.autocomplete.enable && config.vim.autocomplete.cmp.type == "nvim-cmp";
in
{
  imports = [
    ./fidget.nix
    ./lightbulb.nix
    ./lspconfig.nix
    ./lspkind.nix
    ./null-ls.nix
    ./signature.nix
    ./trouble.nix
  ];

  options.vim.lsp = {
    enable = mkEnableOption "LSP, also enabled automatically through null-ls and lspconfig options";
    formatOnSave = mkEnableOption "format on save";
  };

  config.vim = mkIf cfg.enable {
    startPlugins = optional usingNvimCmp "cmp-nvim-lsp";
    autocomplete.cmp.sources = { "nvim_lsp" = "[LSP]"; };
    luaConfigRC.lsp-setup =
      /*
      lua
      */
      ''
        vim.g.formatsave = ${boolToString cfg.formatOnSave};

        local lspconfig = require('lspconfig')
        local util = require('lspconfig.util')
        local async = require 'lspconfig.async'
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Default Keymap Options
        local attach_keymaps = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true)

          -- Rename
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {noremap = true, silent = true, desc = "Rename"}, bufnr)
          vim.keymap.set("n", "grn", vim.lsp.buf.rename, {noremap = true, silent = true, desc = "Rename"}, bufnr)
          -- Code Actions
          vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {noremap = true, silent = true, desc = "Code Actions"}, bufnr)
          vim.keymap.set("n", "gra", vim.lsp.buf.code_action, {noremap = true, silent = true, desc = "Code Actions"}, bufnr)
          -- References
          vim.keymap.set("n", "<leader>g", vim.lsp.buf.references, {noremap = true, silent = true, desc = "References"}, bufnr)
          vim.keymap.set("n", "grr", vim.lsp.buf.references, {noremap = true, silent = true, desc = "References"}, bufnr)
          -- Signature
          vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, {noremap = true, silent = true, desc = "Signature Help"}, bufnr)
          vim.keymap.set("n", "grs", vim.lsp.buf.signature_help, {noremap = true, silent = true, desc = "Signature Help"}, bufnr)
          -- Hover
          vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {noremap = true, silent = true, desc = "Hover"}, bufnr)
          vim.keymap.set("n", "grh", vim.lsp.buf.hover, {noremap = true, silent = true, desc = "Hover"}, bufnr)
          -- Format
          vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {noremap = true, silent = true, desc = "Format"}, bufnr)
          vim.keymap.set("n", "grf", vim.lsp.buf.format, {noremap = true, silent = true, desc = "Format"}, bufnr)
          -- GoTo
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {noremap = true, silent = true, desc = "Go To Definition"}, bufnr)
          vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {noremap = true, silent = true, desc = "Go To Declaration"}, bufnr)
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {noremap = true, silent = true, desc = "Go To Implementation"}, bufnr)
          vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, {noremap = true, silent = true, desc = "Go To Type Definition"}, bufnr)

          -- Inlay Hints
          vim.keymap.set("n", "<leader>i"  , function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hint" })
        end

        -- Enable formatting
        format_callback = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              if vim.g.formatsave then
                if client.supports_method("textDocument/formatting") then
                  local params = require'vim.lsp.util'.make_formatting_params({})
                  client.request('textDocument/formatting', params, nil, bufnr)
                end
              end
            end
          })
        end

        default_on_attach = function(client, bufnr)
          attach_keymaps(client, bufnr)
          format_callback(client, bufnr)
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        ${optionalString usingNvimCmp "capabilities = require('cmp_nvim_lsp').default_capabilities()"}
      '';
  };
}
