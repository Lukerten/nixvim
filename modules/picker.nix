{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.fzf;
in {
  options.vim.fzf = {
    enable = mkEnableOption "enable fzf-lua";
  };

  config.vim = mkIf cfg.enable {
    startPlugins = [
      "fzf-lua"
    ];

    luaConfigRC.fzf-maps =
      nvim.dag.entryAnywhere
      # lua
      ''
        if ${boolToString config.vim.keys.whichKey.enable} then
          local wk = require("which-key")
          wk.add({
            -- File pickers
            { "<leader>s", group = "Find" },
            { "<leader>sf", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find Files" },
            { "<leader>sg", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Live Grep" },
            { "<leader>ss", "<cmd>lua require('fzf-lua').grep()<CR>", desc = "Grep" },
            { "<leader>sr", "<cmd>lua require('fzf-lua').oldfiles()<CR>", desc = "Recent Files" },
            { "<leader>sm", "<cmd>lua require('fzf-lua').marks()<CR>", desc = "Marks" },
            { "<leader><space>", "<cmd>lua require('fzf-lua').grep_cword()<CR>", desc = "Grep Current Word" },

            -- Buffer picker
            { "<Tab>", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "Buffers" },

            -- Git pickers
            { "<leader>sv", group = "Git" },
            { "<leader>svc", "<cmd>lua require('fzf-lua').git_commits()<CR>", desc = "Git Commits" },
            { "<leader>svb", "<cmd>lua require('fzf-lua').git_branches()<CR>", desc = "Git Branches" },
            { "<leader>svs", "<cmd>lua require('fzf-lua').git_status()<CR>", desc = "Git Status" },
            { "<leader>svx", "<cmd>lua require('fzf-lua').git_stash()<CR>", desc = "Git Stash" },
          })

          -- LSP pickers (conditional)
          if ${boolToString config.vim.lsp.enable} then
            wk.add({
              { "<leader>sl", group = "LSP" },
              { "<leader>slr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", desc = "LSP References" },
              { "<leader>sli", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", desc = "LSP Implementations" },
              { "<leader>slD", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", desc = "LSP Definitions" },
              { "<leader>slt", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", desc = "LSP Type Definitions" },
              { "<leader>sld", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>", desc = "LSP Workspace Diagnostics" },
              { "<leader>sla", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "LSP Code Actions" },
            })
          end
        end
      '';

    luaConfigRC.fzf =
      nvim.dag.entryAnywhere
      # lua
      ''
        require("fzf-lua").setup({
          "telescope",
          fzf_opts = {
            ["--layout"] = "reverse"
          }
        })
      '';
  };
}
