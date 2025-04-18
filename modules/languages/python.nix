{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.python;

  defaultServer = "pyright";
  servers = {
    pyright = {
      package = pkgs.pyright;
      lspConfig =
        /*
        lua
        */
        ''
          lspconfig.pyright.setup{
            capabilities = capabilities;
            on_attach = default_on_attach;
            cmd = {"${cfg.lsp.package}/bin/pyright-langserver", "--stdio"}
          }
        '';
    };
  };

  defaultFormat = "black";
  formats = {
    black = {
      package = pkgs.black;
      nullConfig =
        /*
        lua
        */
        ''
          table.insert(
            ls_sources,
            null_ls.builtins.formatting.black.with({
              command = "${cfg.format.package}/bin/black",
            })
          )
        '';
    };
  };
in {
  options.vim.languages.python = {
    enable = mkEnableOption "Python language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Python treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "python";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Python LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "Python LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Python LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

    format = {
      enable = mkOption {
        description = "Enable Python formatting";
        type = types.bool;
        default = config.vim.languages.enableFormat;
      };
      type = mkOption {
        description = "Python formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };
      package = mkOption {
        description = "Python formatter package";
        type = types.package;
        default = formats.${cfg.format.type}.package;
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
      lsp.lspconfig.sources.python-lsp = servers.${cfg.lsp.server}.lspConfig;
    })

    (mkIf cfg.format.enable {
      lsp.null-ls.enable = true;
      lsp.null-ls.sources.python-format = formats.${cfg.format.type}.nullConfig;
    })
  ]);
}
