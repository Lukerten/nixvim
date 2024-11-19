{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.visual.neovide;
in {
  options.vim.visual.neovide = {
    enable = mkEnableOption "Neovide gui";

    font = {
      name = mkOption {
        description = "Font name";
        type = types.str;
        default = "FiraCode Nerd Font";
      };
      size = mkOption {
        description = "Font size";
        type = types.int;
        default = 10;
      };
      style = mkOption {
        description = "Font style";
        type = types.str;
        default = "Medium";
      };
    };
  };

  config = mkIf (cfg.enable) {
    vim.luaConfigRC.gui =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        vim.g.neovide_fullscreen = false
        vim.g.neovide_hide_mouse_when_typing = false
        vim.g.neovide_refresh_rate = 165
        vim.g.neovide_cursor_vfx_mode = "ripple"
        vim.g.neovide_cursor_animate_command_line = true
        vim.g.neovide_cursor_animate_in_insert_mode = true
        vim.g.neovide_cursor_vfx_particle_lifetime = 5.0
        vim.g.neovide_cursor_vfx_particle_density = 14.0
        vim.g.neovide_cursor_vfx_particle_speed = 12.0
        vim.g.neovide_transparency = 0.91
        vim.o.guifont = "FiraCode Nerd Font:h10:Medium:i"

        function _G.OpenMultipleTerminalsInNewTab()
          vim.cmd("tabnew")
          vim.cmd("terminal")
          vim.cmd("vsplit")
          vim.cmd("terminal")
          vim.cmd("split")
          vim.cmd("terminal")
        end

        function _G.OpenDoubleTerminalsInNewTab()
          vim.cmd("tabnew")
          vim.cmd("terminal")
          vim.cmd("vsplit")
          vim.cmd("terminal")
        end

        vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
        vim.keymap.set("n", "<leader>Tv", ":vsplit | terminal<CR>", {desc = "Open vertical split terminal"})
        vim.keymap.set("n", "<leader>Th", ":split | terminal<CR>", {desc = "Open horizontal split terminal"})
        vim.keymap.set("n", "<leader>Tt", ":lua OpenDoubleTerminalsInNewTab()<CR>", {desc = "Open terminal in new tab"})
        vim.keymap.set("n", "<leader>Tm", ":lua OpenMultipleTerminalsInNewTab()<CR>", {desc = "Open terminal in new tab"})
      '';
  };
}
