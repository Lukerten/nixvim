{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.kotlin;

  defaultServer = "kotlin";
  servers = {
    kotlin = {
      package = pkgs.kotlin-language-server;
      lspConfig =
        /*
        lua
        */
        ''
          lspconfig.kotlin_language_server.setup{
            capabilities = capabilities;
            on_attach = default_on_attach,
            cmd = {'${cfg.lsp.package}/bin/kotlin-language-server'};
          }
        '';
    };
  };

  defaultFormat = "ktlint";
  formats = {
    ktlint = {
      package = pkgs.ktlint;
      nullConfig =
        /*
        lua
        */
        ''
          table.insert(
            ls_sources,
            null_ls.builtins.formatting.ktlint.with({
              command = "${cfg.format.package}/bin/ktlint";
            })
          )
        '';
    };
  };

  defaultDiagnostics = ["ktlint"];
  diagnostics = {
    ktlint = {
      package = pkgs.ktlint;
      nullConfig = pkg: ''
        table.insert(
          ls_sources,
          null_ls.builtins.diagnostics.ktlint.with({
            command = "${pkg}/bin/ktlint",
          })
        )
      '';
    };
  };
in {
  options.vim.languages.kotlin = {
    enable = mkEnableOption "Kotlin language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Kotlin treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "kotlin";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Kotlin LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "kotlin LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Kotlin LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

    format = {
      enable = mkOption {
        description = "Enable Kotlin formatting";
        type = types.bool;
        default = config.vim.languages.enableFormat;
      };
      type = mkOption {
        description = "Kotlin formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };
      package = mkOption {
        description = "Kotlin formatter package";
        type = types.package;
        default = formats.${cfg.format.type}.package;
      };
    };

    extraDiagnostics = {
      enable = mkOption {
        description = "Enable extra Kotlin diagnostics";
        type = types.bool;
        default = config.vim.languages.enableExtraDiagnostics;
      };
      types = lib.nvim.types.diagnostics {
        langDesc = "Kotlin";
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
      lsp.lspconfig.enable = true;
      lsp.lspconfig.sources.kotlin-lsp = servers.${cfg.lsp.server}.lspConfig;
    })

    (mkIf cfg.format.enable {
      lsp.null-ls.enable = true;
      lsp.null-ls.sources.kotlin-format = formats.${cfg.format.type}.nullConfig;
    })

    (mkIf cfg.extraDiagnostics.enable {
      lsp.null-ls.enable = true;
      lsp.null-ls.sources = lib.nvim.languages.diagnosticsToLua {
        lang = "kotlin";
        config = cfg.extraDiagnostics.types;
        inherit diagnostics;
      };
    })
  ]);
}
