{
  plugins.trouble.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>TroubleToggle<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Trouble Toggle";
      };
    }

    {
      mode = "n";
      key = "<leader>tw";
      action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Workspace Diagnostics";
      };
    }

    {
      mode = "n";
      key = "<leader>tq";
      action = "<cmd>TroubleToggle quickfix<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Quickfix";
      };
    }

    {
      mode = "n";
      key = "gR";
      action = "<cmd>TroubleToggle lsp_references<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Lsp References";
      };
    }
  ];
}
