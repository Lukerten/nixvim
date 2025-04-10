{
  pkgs,
  lib,
  check ? true,
}: let
  modules = [
    ./languages
    ./lsp
    ./basic.nix
    ./completion.nix
    ./core.nix
    ./debug.nix
    ./filetree.nix
    ./git.nix
    ./keys.nix
    ./picker.nix
    ./terminal.nix
    ./theme.nix
    ./treesitter.nix
    ./visual.nix
  ];

  pkgsModule = {
    config = {
      _module.args.baseModules = modules;
      _module.args.pkgsPath = lib.mkDefault pkgs.path;
      _module.args.pkgs = lib.mkDefault pkgs;
      _module.check = check;
    };
  };
in
  modules ++ [pkgsModule]
