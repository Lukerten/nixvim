{
  imports = [
    ./ccc.nix
    ./coverage.nix
    ./schemastore.nix
    ./dadbod.nix
    ./dap.nix
    ./git-worktree.nix
    ./gitlinker.nix
    ./harpoon.nix
    ./neocord.nix
    ./neogit.nix
    ./neorg.nix
    ./remote-nvim.nix
    ./schemastore.nix
    ./todo-comment.nix
    ./yanky.nix
  ];

  plugins = {
    nvim-autopairs.enable = true;
    vim-surround.enable = true;
    undotree.enable = true;
    bufdelete.enable = true;
    gx.enable = true;
  };

  keymaps = [
    {
      key = "<leader>x";
      action = ":Bdelete <CR>";
      mode = "n";
      options = {
        desc = "Delete buffer";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        desc = "Undotree";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = "v";
      key = "<leader>b";
      action = "<cmd>Browse<cr>";
      options = {
        desc = "Browse";
        silent = true;
        noremap = true;
      };
    }
  ];
}
