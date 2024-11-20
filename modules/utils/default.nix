{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils;
in {
  imports = [
    ./copilot.nix
    ./debug.nix
    ./kommentary.nix
    ./lazygit.nix
    ./obsidian.nix
    ./telescope.nix
    ./undo.nix
    ./vimwiki.nix
    ./which.nix
  ];
  options.vim.utils = {
    enable = mkEnableOption "utilities & integrations";
  };

  config.vim.utils = mkIf cfg.enable {
    copilot.enable = mkDefault true;
    kommentary.enable = mkDefault true;
    lazygit.enable = mkDefault true;
    obsidian.enable = mkDefault true;
    telescope.enable = mkDefault true;
    undo.enable =  mkDefault true;
    vimwiki.enable =  mkDefault true;
    whichKey.enable = mkDefault true;
    debug = {
      virtualText.enable = mkDefault true;
      ui.enable = mkDefault true;
    };
  };
}
