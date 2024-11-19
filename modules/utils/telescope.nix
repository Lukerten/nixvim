{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.telescope;
in {
  options.vim.utils.telescope = {
    enable = mkEnableOption "enable telescope";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "telescope"
      "telescope-project"
    ];

    vim.nnoremap =
      {
        "<Tab>" = "<cmd> Telescope buffers<CR>";
        "<leader>Tf" = "<cmd> Telescope find_files<CR>";
        "<leader>Tg" = "<cmd> Telescope grep_string<CR>";
        "<leader>Th" = "<cmd> Telescope help_tags<CR>";
        "<leader>Tt" = "<cmd> Telescope<CR>";
        "<leader>Tc" = "<cmd> TodoTelescope<CR>";
        "<leader><space>" = "<cmd> Telescop live_grep<CR>";
        "<leader>Tvcw" = "<cmd> Telescope git_commits<CR>";
        "<leader>Tvcb" = "<cmd> Telescope git_bcommits<CR>";
        "<leader>Tvb" = "<cmd> Telescope git_branches<CR>";
        "<leader>Tvs" = "<cmd> Telescope git_status<CR>";
        "<leader>Tvx" = "<cmd> Telescope git_stash<CR>";
      }
      // (
        if config.vim.lsp.enable
        then {
          "<leader>Tlsb" = "<cmd> Telescope lsp_document_symbols<CR>";
          "<leader>Tlsw" = "<cmd> Telescope lsp_workspace_symbols<CR>";
          "<leader>Tlr" = "<cmd> Telescope lsp_references<CR>";
          "<leader>Tli" = "<cmd> Telescope lsp_implementations<CR>";
          "<leader>TlD" = "<cmd> Telescope lsp_definitions<CR>";
          "<leader>Tlt" = "<cmd> Telescope lsp_type_definitions<CR>";
          "<leader>Tld" = "<cmd> Telescope diagnostics<CR>";
          "<leader>Tla" = "<cmd> Telescope lsp_code_action<CR>";
        }
        else {}
      )
      // (
        if config.vim.treesitter.enable
        then {
          "<leader>Ts" = "<cmd> Telescope treesitter<CR>";
        }
        else {}
      );

    vim.luaConfigRC.telescope =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require'telescope'.load_extension('project')
        require("telescope").setup {
          defaults = {
            vimgrep_arguments = {
              "${pkgs.ripgrep}/bin/rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case"
            },
            pickers = {
              find_command = {
                "${pkgs.fd}/bin/fd",
              },
            },
          }
        }
      '';
  };
}
