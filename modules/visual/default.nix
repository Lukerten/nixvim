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
    ./alpha.nix
    ./autopairs.nix
    ./bufferline.nix
    ./gitsigns.nix
    ./ibl.nix
    ./lualine.nix
    ./neovide.nix
    ./nvimtree.nix
    ./noice.nix
    ./nwd.nix
    ./theme.nix
    ./todo.nix
  ];

  options.vim.visual = {
    enable = mkEnableOption "visual enhancements";
  };

  config.vim.visual = mkIf cfg.enable {
    autopairs.enable = mkDefault true;
    alpha.enable = mkDefault true;
    bufferline.enable = mkDefault true;
    gitsigns.enable = mkDefault true;
    gitsigns.codeActions = mkDefault true;
    neovide.enable = mkDefault true;
    indentBlankline.enable = mkDefault true;
    lualine.enable = mkDefault true;
    noice.enable = mkDefault true;
    nvimTree.enable = mkDefault true;
    nvimWebDevicons.enable = mkDefault true;
    todo.enable = mkDefault true;
    theme.enable = mkDefault true;
  };
}
