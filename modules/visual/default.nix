{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.visual;
in {
  imports = [
    ./autopairs.nix
    ./ibl.nix
    ./lualine.nix
    ./luatab.nix
    ./neovide.nix
    ./noice.nix
    ./project.nix
    ./nwd.nix
    ./ranger.nix
    ./theme.nix
    ./todo.nix
  ];

  options.vim.visual = {
    enable = mkEnableOption "visual enhancements.";
  };
}
