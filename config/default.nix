{
  viAlias = true;
  vimAlias = true;
  luaLoader.enable = true;
  plugins.lz-n.enable = true;

  imports = [
    ./completion
    ./copilot
    ./languages
    ./theme
    ./utils
    ./snippets
    ./visual
    ./keymap.nix
    ./opts.nix
    ./performance.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
