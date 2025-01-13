{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.vue;

  defaultServer = "vuels";
  servers = {
    vuels = {
      package = pkgs.nodePackages.vls;
      lspConfig =
        /*
        lua
        */
        ''
          local util = require('lspconfig.util')
          lspconfig.vuels.setup {
            capabilities = capabilities,
            on_attach = attach_keymaps,
            filetypes = { 'vue' },
            root_dir = util.root_pattern('package.json', 'vue.config.js'),
            cmd = { "${pkgs.nodePackages.vls}/bin/vls", "--stdio" },
            init_options = {
              config = {
                vetur = {
                  useWorkspaceDependencies = false,
                  validation = {
                    template = true,
                    style = true,
                    script = true,
                  },
                  completion = {
                    autoImport = false,
                    useScaffoldSnippets = false,
                    tagCasing = 'kebab',
                  },
                  format = {
                    defaultFormatter = {
                      js = 'none',
                      ts = 'none',
                    },
                    defaultFormatterOptions = {},
                    scriptInitialIndent = false,
                    styleInitialIndent = false,
                  },
                },
                css = {},
                html = {
                  suggest = {},
                },
                javascript = {
                  format = {},
                },
                typescript = {
                  format = {},
                },
                emmet = {},
                stylusSupremacy = {},
              },
            },
          }
        '';
    };
  };
in {
  options.vim.languages.vue = {
    enable = mkEnableOption "Vue language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Vue treesitter support";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      packages = mkOption {
        description = "Tree-sitter grammars for Vue and TypeScript";
        type = types.listOf types.package;
        default = [pkgs.vimPlugins.nvim-treesitter.builtGrammars.vue pkgs.vimPlugins.nvim-treesitter.builtGrammars.typescript];
      };
    };

    lsp = {
      enable = mkOption {
        description = "Enable Vue LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "Vue LSP server to use";
        type = types.str;
        default = defaultServer;
      };
      package = mkOption {
        description = "Vue LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = cfg.treesitter.packages;
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.vue-lsp = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
