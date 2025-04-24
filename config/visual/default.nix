{
  imports = [
    ./bufferline.nix
    ./dashboard.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./leap.nix
    ./lualine.nix
    ./noice.nix
    ./notify.nix
    ./nvim-tree.nix
    ./tiny-inline-diagnostics.nix
    ./trouble.nix
    ./which-key.nix
  ];

  plugins = {
    todo-comments.enable = true;
    quicker.enable = true;
  };

  extraConfigLua =
    # lua
    ''
      vim.wo.fillchars='eob: '
      vim.opt.fillchars='eob: '
    '';
}
