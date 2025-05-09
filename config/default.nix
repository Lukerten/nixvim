{
  viAlias = true;
  vimAlias = true;
  luaLoader.enable = true;
  plugins.lz-n.enable = true;

  imports = [
    ./completion
    ./copilot
    ./languages
    ./utils
    ./snippets
    ./terminal
    ./visual
    ./autocmd.nix
    ./keymap.nix
    ./opts.nix
    ./performance.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
