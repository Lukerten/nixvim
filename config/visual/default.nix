{
  imports = [
    ./dashboard.nix
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
