{
  viAlias = true;
  vimAlias = true;
  luaLoader.enable = true;
  plugins.lz-n.enable = true;

  imports = [
    ./completion
    ./copilot
    ./theme
    ./keymap.nix
    ./opts.nix
    ./performance.nix
    ./treesitter.nix
  ];
}
