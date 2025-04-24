{
  lib,
  config,
  ...
}:
with lib; let
  hasDadbod = config.plugins.vim-dadbod-ui.enable;
  hasTodoComment = config.plugins.todo-comments.enable;
  hasTelescope = config.plugins.telescope.enable;
  hasTelescopeProject = config.plugins.telescope.extensions.project.enable;
  hasNeoGit = config.plugins.neogit.enable;
  hasNeorg = config.plugins.neorg.enable;
  hasRemoteNvim = config.plugins.remote-nvim.enable;
in {
  plugins.dashboard = {
    enable = true;
    settings = {
      theme = "hyper";
      change_to_vcs_root = true;

      hide = {
        statusline = true;
        tabline = true;
      };

      config = {
        packages.enable = true;
        mru.limit = 10;

        project.enable = true;
        week_header.enable = true;

        header = [
          "                                   "
          "                                   "
          "                                   "
          "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
          "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
          "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
          "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
          "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
          "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
          "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
          " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
          " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
          "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
          "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "
          "                                   "
        ];

        shortcut = let
          key_format = " %s";
          icon_hl = "Title";
          desc_hl = "String";
        in
          [
            {
              inherit key_format icon_hl desc_hl;
              icon = "  ";
              desc = "New";
              action.__raw = "function() vim.cmd[[ene]] end";
              key = "n";
            }
          ]
          ++ optionals (hasTodoComment && hasTelescope) [
            {
              inherit key_format icon_hl desc_hl;
              icon = "  ";
              desc = "Todos";
              action.__raw = "function() vim.cmd[[TodoTelescope]] end";
              key = "t";
            }
          ]
          ++ optionals hasDadbod [
            {
              inherit key_format icon_hl desc_hl;
              icon = "󰒋  ";
              desc = "DB";
              action.__raw = "function() vim.cmd[[DBUI]] end";
              key = "d";
            }
          ]
          ++ optionals hasNeoGit [
            {
              inherit key_format icon_hl desc_hl;
              icon = "  ";
              desc = "Neogit";
              action.__raw = "function() vim.cmd[[Neogit]] end";
              key = "s";
            }
          ]
          ++ optionals hasRemoteNvim [
            {
              inherit key_format icon_hl desc_hl;
              icon = "󰒉  ";
              desc = "Remote";
              action.__raw = "function() vim.cmd[[RemoteStart]] end";
              key = "r";
            }
          ]
          ++ optionals hasNeorg [
            {
              inherit key_format icon_hl desc_hl;
              icon = "󰍉  ";
              desc = "Neorg";
              action.__raw = "function() vim.cmd[[Neorg index]] end";
              key = "o";
            }
          ]
          ++ [
            {
              inherit key_format icon_hl desc_hl;
              icon = "  ";
              desc = "Quit";
              action.__raw = "function() vim.cmd[[qa]] end";
              key = "q";
            }
          ];

        footer = ["Those that can, do. Those that can't, complain."];
      };
    };
  };
}
