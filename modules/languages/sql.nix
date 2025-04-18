{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.sql;
  sqlfluffDefault = "sqlfluff";

  defaultServer = "sqlls";
  servers = {
    sqlls = {
      package = pkgs.sqls;
      lspConfig =
        /*
        lua
        */
        ''
          local root_dir = require('lspconfig/util').root_pattern('.git', 'flake.nix')(vim.fn.getcwd())
          lspconfig.sqlls.setup {
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = { "${cfg.lsp.package}/bin/sqls", "-config", string.format("%s/config.yml", root_dir) };
            root_dir = function(fname)
              return root_dir
            end;
          }
        '';
    };
  };
  defaultFormat = "sqlfluff";
  formats = {
    sqlfluff = {
      package = [sqlfluffDefault];
      nullConfig =
        /*
        lua
        */
        ''
          table.insert(
            ls_sources,
            null_ls.builtins.formatting.sqlfluff.with({
              command = "${nvim.languages.commandOptToCmd cfg.format.package "sqlfluff"}",
              extra_args = {"--dialect", "${cfg.dialect}"}
            })
          )
        '';
    };
  };

  defaultDiagnostics = ["sqlfluff"];
  diagnostics = {
    sqlfluff = {
      package = pkgs.${sqlfluffDefault};
      nullConfig = pkg:
      /*
      lua
      */
      ''
        table.insert(
          ls_sources,
          null_ls.builtins.diagnostics.sqlfluff.with({
            command = "${pkg}/bin/sqlfluff",
            extra_args = {"--dialect", "${cfg.dialect}"}
          })
        )
      '';
    };
  };
in {
  options.vim.languages.sql = {
    enable = mkEnableOption "SQL language support";

    dialect = mkOption {
      description = "SQL dialect for sqlfluff (if used)";
      type = types.str;
      default = "ansi";
    };

    treesitter = {
      enable = mkOption {
        description = "Enable SQL treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "sql";
    };

    lsp = {
      enable = mkOption {
        description = "Enable SQL LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "SQL LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "SQL LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

    format = {
      enable = mkOption {
        description = "Enable SQL formatting";
        type = types.bool;
        default = config.vim.languages.enableFormat;
      };
      type = mkOption {
        description = "SQL formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };
      package = nvim.options.mkCommandOption pkgs {
        description = "SQL formatter";
        inherit (formats.${cfg.format.type}) package;
      };
    };

    extraDiagnostics = {
      enable = mkOption {
        description = "Enable extra SQL diagnostics";
        type = types.bool;
        default = config.vim.languages.enableExtraDiagnostics;
      };
      types = lib.nvim.options.mkDiagnosticsOption {
        langDesc = "SQL";
        inherit diagnostics;
        inherit defaultDiagnostics;
      };
    };
  };

  config.vim = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      treesitter.enable = true;
      treesitter.grammars = [cfg.treesitter.package];
    })

    (mkIf cfg.lsp.enable {
      startPlugins = ["sqls-nvim"];

      lsp.lspconfig.enable = true;
      lsp.lspconfig.sources.sql-lsp = servers.${cfg.lsp.server}.lspConfig;
    })

    (mkIf cfg.format.enable {
      lsp.null-ls.enable = true;
      lsp.null-ls.sources."sql-format" = formats.${cfg.format.type}.nullConfig;
    })

    (mkIf cfg.extraDiagnostics.enable {
      lsp.null-ls.enable = true;
      lsp.null-ls.sources = lib.nvim.languages.diagnosticsToLua {
        lang = "sql";
        config = cfg.extraDiagnostics.types;
        inherit diagnostics;
      };
    })
  ]);
}
