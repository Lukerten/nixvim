{
  config,
  lib,
  ...
}: {
  keymaps = lib.mkIf config.plugins.neo-tree.enable [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree action=focus reveal toggle<CR>";
      options = {
        desc = "Explorer toggle";
      };
    }
  ];

  plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;

    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        hideHidden = false;
        visible = true;

        neverShowByPattern = [
          ".direnv"
          ".git"
        ];
      };

      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };
      useLibuvFileWatcher.__raw = ''vim.fn.has "win32" ~= 1'';
    };

    window = {
      width = 40;
      autoExpandWidth = false;
    };

    eventHandlers = {
      file_opened =
        # lua
        ''
          function(file_path)
            require("neo-tree").close_all()
          end
        '';
    };
  };
}
