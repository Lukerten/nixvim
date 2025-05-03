{
  imports = [
    ./bufferline.nix
    ./dashboard.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./leap.nix
    ./lualine.nix
    ./neotree.nix
    ./noice.nix
    ./notify.nix
    ./nvim-ufo.nix
    ./snacks.nix
    ./theme.nix
    ./tiny-id.nix
    ./trouble.nix
    ./which-key.nix
    ./yazi.nix
  ];

  plugins = {
    todo-comments.enable = true;
    quicker.enable = true;
  };

  extraConfigLua =
    # lua
    ''
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "0"
    '';
}
