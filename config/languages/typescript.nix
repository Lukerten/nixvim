{pkgs, ...}: {
  plugins = {
    conform-nvim = {
      settings.formatters_by_ft = {
        javascript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        typescript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        javascriptreact = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        typescriptreact = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
      };
    };
    lsp.servers.eslint.enable = true;
    typescript-tools = {
      enable = true;

      lazyLoad.settings.ft = [
        "typescript"
        "javascript"
        "typescriptreact"
        "javascriptreact"
      ];

      settings = {
        settings = {
          code_lens = "off";
          complete_function_calls = false;
          disable_member_code_lens = true;
          expose_as_code_action = "all";
          include_completions_with_insert_text = true;
          publish_diagnostic_on = "insert_leave";
          separate_diagnostic_server = true;
          tsserver_locale = "en";
          tsserver_max_memory = "auto";
          tsserver_path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
          jsx_close_tag = {
            enable = false;
            filetypes = [
              "javascriptreact"
              "typescriptreact"
            ];
          };
        };
      };
    };
    none-ls.sources.formatting.prettier.disableTsServerFormatter = false;
  };
}
