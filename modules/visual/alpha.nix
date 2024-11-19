{
  lib,
  config,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.visual.alpha;
in {
  options.vim.visual.alpha = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the glow plugin for markdown preview.";
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["alpha-nvim"];
    vim.luaConfigRC.alpha-nvim =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''

        function _RECENT_PROJECTS()
          require'telescope'.extensions.frecency.frecency()
        end

        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
          "                                   ",
          "                                   ",
          "                                   ",
          "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
          "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
          "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
          "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
          "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
          "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
          "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
          " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
          " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
          "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
          "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
          "                                   ",
        }


        dashboard.section.buttons.val = {
          dashboard.button( "p", "  Find project"        , ":Telescope project <CR>"),
          dashboard.button( "f", "  Find files"          , ":Telescope find_files <CR>"),
          dashboard.button( "F", "󱎸  Find text"           , ":Telescope live_grep <CR>"),
          dashboard.button( "r", "  Recently used files" , ":Telescope oldfiles <CR>"),

          dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        dashboard.section.footer.val = {
          "    if debugging is the process of removing bugs",
          " then programming must be the process of adding them ",
          " ",
          "          - Edsger W. Dijkstra - ",
        }

        dashboard.section.header.opts.hl = "Title"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.section.footer.opts.hl = "Error"
        dashboard.section.header.opts.spacing = 0
        dashboard.opts.opts.noautocmd = true
        require("alpha").setup(dashboard.opts)

        -- Alpha Keybind
        vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>Alpha<CR>", { noremap = true, silent = true, desc = "Home" })
      '';
  };
}
