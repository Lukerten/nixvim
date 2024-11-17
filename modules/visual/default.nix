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
    ./alpha.nix
    ./bufferline.nix
    ./ibl.nix
    ./lualine.nix
    ./neovide.nix
    ./nvimtree.nix
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

  config = mkIf cfg.enable {
    vim.visual.autopairs.enable = mkDefault true;
    vim.visual.alpha.enable = mkDefault true;
    vim.visual.bufferline.enable = mkDefault true;
    vim.visual.gui.enable = mkDefault false;
    vim.visual.indentBlankline.enable = mkDefault true;
    vim.visual.lualine.enable = mkDefault true;
    vim.visual.noice.enable = mkDefault true;
    vim.visual.nvimTree.enable = mkDefault true;
    vim.visual.nvimWebDevicons.enable = mkDefault true;
    vim.visual.ranger.enable = mkDefault true;
    vim.visual.todo.enable = mkDefault true;
    vim.visual.theme.enable = mkDefault true;
  };
}
