{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.remote;
in {
  options.vim.utils.remote = {
    enable = mkEnableOption "enable remote nvim plugin";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "plenary-nvim"
      "nui"
      "telescope"
      "remote-nvim"
    ];

    vim.luaConfigRC.obsidian =
      nvim.dag.entryAnywhere # lua
      ''
       local remoteConfig = {
          -- Configuration for devpod connections
          devpod = {
            search_style = "current_dir_only",
            dotfiles = {
                path = nil,
                install_script = nil
            },
            gpg_agent_forwarding = false,
            container_list = "running_only",
          },
          ssh_config = {
            ssh_prompts = {
              {
                match = "password:",
                type = "secret",
                value_type = "dynamic",
                value = "",
              },
              {
                match = "continue connecting (yes/no/[fingerprint])?",
                type = "plain",
                value_type = "static",
                value = "",
              },
              {
                match = "Enter passphrase for key",
                type = "secret",
                value_type = "dynamic",
                value = "",
              }
            },
          },
          progress_view = {
            type = "popup",
          },
          offline_mode = {
            enabled = false,
            no_github = false,
          },
        }

        require("remote-nvim").setup(remoteConfig)
      '';
  };
}


