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
    ./remote-nvim.nix
    ./schemastore.nix
    ./todo-comment.nix
    ./yanky.nix
  ];

  plugins = {
    bufdelete.enable = true;
    nvim-autopairs.enable = true;
    gx.enable = true;
    sleuth.enable = true;
    undotree.enable = true;
    vim-surround.enable = true;
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
