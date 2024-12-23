{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.bufferline;
in {
  options.vim.visual.bufferline = {
    enable = mkEnableOption "Enable bufferline";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["bufferline" "bbye"];
    vim.luaConfigRC.todo =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", {silent = true, noremap = true, desc = "Next buffer"})
        vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>", {silent = true, noremap = true, desc = "Previous buffer"})
        require("bufferline").setup {
          options = {
            numbers = "none",
            close_command = "Bdelete! %d",
            right_mouse_command = "Bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator_icon = nil,
            indicator = { style = "icon", icon = "▎"},
            buffer_close_icon = '',
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 30,
            max_prefix_length = 30,
            tab_size = 21,
            diagnostics = nvim_lsp,
            diagnostics_update_in_insert = false,
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true,
            separator_style = "thin",
            enforce_regular_tabs = true,
            always_show_bufferline = true,
          },
        }
      '';
  };
}
