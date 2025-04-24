{
  viAlias = true;
  vimAlias = true;
  luaLoader.enable = true;
  plugins.lz-n.enable = true;

  imports = [
    ./completion
    ./performance.nix
  ];
}
