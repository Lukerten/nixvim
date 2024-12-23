{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
  usingNvimCmp = config.vim.autocomplete.enable && config.vim.autocomplete.type == "nvim-cmp";
in {
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

  config = mkIf cfg.enable {
    vim.startPlugins = optional usingNvimCmp "cmp-nvim-lsp";
    vim.autocomplete.sources = {"nvim_lsp" = "[LSP]";};
    vim.luaConfigRC.lsp-setup =
      /*
      lua
      */
      ''
        vim.g.formatsave = ${boolToString cfg.formatOnSave};

        local attach_keymaps = function(client, bufnr)
          local opts = { noremap=true, silent=true }
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap=true, silent=true, desc="Go to declaration" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true, desc="Go to definition" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap=true, silent=true, desc="Show hover information" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap=true, silent=true, desc="Go to implementation" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap=true, silent=true, desc="Show signature help" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap=true, silent=true, desc="Show references" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap=true, silent=true, desc="Add workspace folder" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { noremap=true, silent=true, desc="Remove workspace folder" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { noremap=true, silent=true, desc="List workspace folders" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap=true, silent=true, desc="Rename" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true, desc="Show diagnostics" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap=true, silent=true, desc="Previous diagnostic" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap=true, silent=true, desc="Next diagnostic" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap=true, silent=true, desc="Set location list" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap=true, silent=true, desc="Code action" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap=true, silent=true, desc="Format" })
          vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap=true, silent=true, desc="Format" })
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap=true, silent=true, desc="Format" })
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
