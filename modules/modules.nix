{
  pkgs,
  lib,
  check ? true,
}: let
  modules = [
    ./basic
    ./build
    ./completion
    ./core
    ./debug
    ./languages
    ./lsp
    ./snippets
    ./treesitter
    ./utils
    ./visual
  ];

  pkgsModule = {config, ...}: {
    config = {
      _module.args.baseModules = modules;
      _module.args.pkgsPath = lib.mkDefault pkgs.path;
      _module.args.pkgs = lib.mkDefault pkgs;
      _module.check = check;
    };
  };
in
  modules ++ [pkgsModule]
