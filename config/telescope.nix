{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  hasSnacks = config.plugins.snacks.enable;
in {
  plugins.web-devicons.enable = mkDefault true;
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      project.enable = true;
    };
  };

  # we prefer the snacks version of these!
  keymaps = optionals (!hasSnacks) [
    {
      mode = "n";
      key = "<leader><space>";
      action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
      options = {
        silent = true;
        desc = "Search Files";
      };
    }

    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
      #    lua = true;
      options = {
        silent = true;
        desc = "Search Files";
      };
    }

    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>lua require('telescope.builtin').buffers()<CR>";
      options = {
        silent = true;
        desc = "Search Buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
      options = {
        silent = true;
        desc = "Search Help";
      };
    }

    {
      mode = "n";
      key = "<leader>fd";
      action = "<cmd>lua require('telescope.builtin').diagnostics()<CR>";
      options = {
        silent = true;
        desc = "Search Diagnostics";
      };
    }

    {
      mode = "n";
      key = "<leader>ft";
      action = "<cmd>lua require('telescope.builtin').treesitter()<CR>";
      options = {
        silent = true;
        desc = "Search Treesitter";
      };
    }
  ];
  extraPackages = with pkgs; [fzf];
}
