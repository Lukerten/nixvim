{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.visual.nvimTree;
in {
  options.vim.visual.nvimTree = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable nvim-tree-lua";
    };

    updateCwd = mkOption {
      default = true;
      description = "Update cwd changes";
      type = types.bool;
    };

    float = mkOption {
      default = true;
      description = "Enable filetree float option";
      type = types.bool;
    };

    border = mkOption {
      default = "rounded";
      description = "Border style for the floating window";
      type = types.enum ["none" "rounded" "solid" "double"];
    };

    widthRatio = mkOption {
      default = 0.5;
      description = "Float tree width";
      type = types.float;
    };

    heightRatio = mkOption {
      default = 0.8;
      description = "Float tree height";
      type = types.float;
    };

    treeSide = mkOption {
      default = "left";
      description = "Side the tree will appear on left or right";
      type = types.enum ["left" "right"];
    };

    treeWidth = mkOption {
      default = 25;
      description = "Width of the tree in charecters";
      type = types.int;
    };

    hideFiles = mkOption {
      default = [];
      description = "Files to hide in the file view by default.";
      type = with types; listOf str;
    };

    hideIgnoredGitFiles = mkOption {
      default = false;
      description = "Hide files ignored by git";
      type = types.bool;
    };

    openOnSetup = mkOption {
      default = true;
      description = "Open when vim is started on a directory";
      type = types.bool;
    };

    closeOnLastWindow = mkOption {
      default = true;
      description = "Close when tree is last window open";
      type = types.bool;
    };

    ignoreFileTypes = mkOption {
      default = [];
      description = "Ignore file types";
      type = with types; listOf str;
    };

    closeOnFileOpen = mkOption {
      default = true;
      description = "Closes the tree when a file is opened.";
      type = types.bool;
    };

    resizeOnFileOpen = mkOption {
      default = false;
      description = "Resizes the tree when opening a file.";
      type = types.bool;
    };

    followBufferFile = mkOption {
      default = true;
      description = "Follow file that is in current buffer on tree";
      type = types.bool;
    };

    indentMarkers = mkOption {
      default = true;
      description = "Show indent markers";
      type = types.bool;
    };

    hideDotFiles = mkOption {
      default = false;
      description = "Hide dotfiles";
      type = types.bool;
    };

    openTreeOnNewTab = mkOption {
      default = false;
      description = "Opens the tree view when opening a new tab";
      type = types.bool;
    };

    disableNetRW = mkOption {
      default = false;
      description = "Disables netrw and replaces it with tree";
      type = types.bool;
    };

    hijackNetRW = mkOption {
      default = true;
      description = "Prevents netrw from automatically opening when opening directories";
      type = types.bool;
    };

    trailingSlash = mkOption {
      default = true;
      description = "Add a trailing slash to all folders";
      type = types.bool;
    };

    groupEmptyFolders = mkOption {
      default = true;
      description = "Compact empty folders trees into a single item";
      type = types.bool;
    };

    lspDiagnostics = mkOption {
      default = true;
      description = "Shows lsp diagnostics in the tree";
      type = types.bool;
    };

    systemOpenCmd = mkOption {
      default = "${pkgs.xdg-utils}/bin/xdg-open";
      description = "The command used to open a file with the associated default program";
      type = types.str;
    };

    useSystemClipboard = mkOption {
      default = true;
      description = "Use the system clipboard";
      type = types.bool;
    };

    hijackDirectories = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable directory hijacking";
      };

      autoOpen = mkOption {
        type = types.bool;
        default = true;
        description = "Automatically open hijacked directories";
      };
    };

    updateFocusedFile = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable updating the focused file";
      };

      updateCwd = mkOption {
        type = types.bool;
        default = true;
        description = "Update the current working directory";
      };

      ignoreList = mkOption {
        type = with types; listOf str;
        default = [];
        description = "List of files to ignore";
      };
    };

    systemOpen = {
      cmd = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "The command to open a file with the associated default program";
      };

      args = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Arguments for the system open command";
      };
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["nvim-tree-lua"];

    vim.luaConfigRC.nvimtreelua =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require'nvim-tree'.setup({
          disable_netrw = ${boolToString cfg.disableNetRW},
          hijack_netrw = ${boolToString cfg.hijackNetRW},
          open_on_tab = ${boolToString cfg.openTreeOnNewTab},
          system_open = {
            cmd = ${"'" + cfg.systemOpenCmd + "'"},
          },
          diagnostics = {
            enable = ${boolToString cfg.lspDiagnostics},
          },
          update_cwd = ${boolToString cfg.updateCwd},
          view  = {
            width = 40,
            side = "left",
            number = false,
            relativenumber = false,
          },
          renderer = {
            indent_markers = {
              enable = ${boolToString cfg.indentMarkers},
            },
            add_trailing = ${boolToString cfg.trailingSlash},
            group_empty = ${boolToString cfg.groupEmptyFolders},
            highlight_git = true,
            root_folder_modifier = ":t",
          },
          hijack_directories = {
            enable = ${boolToString cfg.hijackDirectories.enable},
            auto_open = ${boolToString cfg.hijackDirectories.autoOpen},
          },
          update_focused_file = {
            enable = ${boolToString cfg.updateFocusedFile.enable},
            update_cwd = ${boolToString cfg.updateFocusedFile.updateCwd},
            ignore_list = {
              ${builtins.concatStringsSep "\n" (builtins.map (s: "\"" + s + "\",") cfg.updateFocusedFile.ignoreList)}
            },
          },
          system_open = {
            cmd = ${
          if cfg.systemOpen.cmd == null
          then "nil"
          else "'" + cfg.systemOpen.cmd + "'"
        },
            args = {
              ${builtins.concatStringsSep "\n" (builtins.map (s: "\"" + s + "\",") cfg.systemOpen.args)}
            },
          },
          actions = {
            use_system_clipboard = ${boolToString cfg.useSystemClipboard},
            change_dir = {
              enable = ${boolToString cfg.followBufferFile},
            },
            open_file = {
              quit_on_open = ${boolToString cfg.closeOnFileOpen},
              resize_window = ${boolToString cfg.resizeOnFileOpen},
            },
          },
          git = {
            enable = true,
            ignore = ${boolToString cfg.hideIgnoredGitFiles},
          },
          filters = {
            dotfiles = ${boolToString cfg.hideDotFiles},
            custom = {
              ${builtins.concatStringsSep "\n" (builtins.map (s: "\"" + s + "\",") cfg.hideFiles)}
            },
          },
        })

        vim.keymap.set("n", "<leader>Ee", "<cmd>NvimTreeToggle<cr>", {silent = true, noremap = true, desc = "Toggle NvimTree"})
        vim.keymap.set("n", "<leader>Er", "<cmd>NvimTreeRefresh<cr>", {silent = true, noremap = true, desc = "Refresh NvimTree"})
        vim.keymap.set("n", "<leader>Ef", "<cmd>NvimTreeFindFile<cr>", {silent = true, noremap = true, desc = "Find file in NvimTree"})
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", {silent = true, noremap = true, desc = "Focus NvimTree"})
      '';
  };
}
