{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./cpp.nix
    ./csharp.nix
    ./golang.nix
    ./css.nix
    ./html.nix
    ./java.nix
    ./json.nix
    ./just.nix
    ./kotlin.nix
    ./latex.nix
    ./lean.nix
    ./lisp.nix
    ./lua.nix
    ./markdown.nix
    ./nix.nix
    ./php.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./sql.nix
    ./terraform.nix
    ./toml.nix
    ./typescript.nix
    ./typst.nix
    ./yaml.nix
  ];

  userCommands = {
    Conform = {
      desc = "Formatting using conform.nvim";
      range = true;
      command.__raw = ''
        function(args)
          ${lib.optionalString config.plugins.lz-n.enable "require('lz.n').trigger_load('conform.nvim')"}
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range },
          function(err)
            if not err then
              local mode = vim.api.nvim_get_mode().mode
              if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              end
            end
          end)
        end
      '';
    };

    FormatDisable = {
      bang = true;
      command.__raw = ''
        function(args)
           if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end
      '';
      desc = "Disable automatic formatting on save";
    };

    FormatEnable = {
      bang = true;
      command.__raw = ''
        function(args)
           if args.bang then
            vim.b.disable_autoformat = false
          else
            vim.g.disable_autoformat = false
          end
        end
      '';
      desc = "Enable automatic formatting on save";
    };

    FormatToggle = {
      bang = true;
      command.__raw = ''
        function(args)
          if args.bang then
            -- Toggle formatting for current buffer
            vim.b.disable_autoformat = not vim.b.disable_autoformat
          else
            -- Toggle formatting globally
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end
        end
      '';
      desc = "Toggle automatic formatting on save";
    };

    InlineHintsEnable = {
      command.__raw = ''
        function()
          vim.lsp.inlay_hint.enable(true)
        end
      '';
      desc = "Enable lsp inline hints";
    };

    InlineHintsDisable = {
      command.__raw = ''
        function()
          vim.lsp.inlay_hint.enable(false)
        end
      '';
      desc = "Disable lsp inline hints";
    };

    InlineHintsToggle = {
      command.__raw = ''
        function()
          vim.lsp.inlay_hint.toggle()
        end
      '';
      desc = "Toggle lsp inline hints";
    };
  };

  plugins = {
    none-ls.enable = true;
    lsp-signature.enable = true;
    conform-nvim = {
      enable = true;

      lazyLoad.settings = {
        cmd = [
          "ConformInfo"
        ];
        event = ["BufWritePre"];
      };

      luaConfig.pre = ''
        local slow_format_filetypes = {}
      '';

      settings = {
        default_format_opts = {
          lsp_format = "fallback";
        };

        format_on_save =
          # Lua
          ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

               -- Disable autoformat for slow filetypes
              if slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
              end

               -- Disable autoformat for files in a certain path
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              if bufname:match("/node_modules/") or bufname:match("/.direnv/") then
                return
              end

              local function on_format(err)
                if err and err:match("timeout$") then
                  slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
              end

              return { timeout_ms = 200, lsp_fallback = true }, on_format
             end
          '';

        format_after_save =
          # Lua
          ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
              end

              return { lsp_fallback = true }
            end
          '';
        formatters_by_ft = {
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
      };
    };

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        typos_lsp = {
          enable = true;
          extraOptions.init_options.diagnosticSeverity = "Hint";
        };
        harper_ls = {
          enable = true;
          settings = {
            "harper-ls" = {
              linters = {
                boring_words = true;
                linking_verbs = true;
                sentence_capitalization = false;
                spell_check = false;
              };
              codeActions.forceStable = true;
            };
          };
        };
      };
      keymaps = {
        diagnostic = {
          "<leader>Ch" = "open_float";
          "[" = "goto_prev";
          "]" = "goto_next";
        };
        lspBuf = {
          "gD" = "declaration";
          "gd" = "definition";
          "gr" = "references";
          "gI" = "implementation";
          "gy" = "type_definition";
          "<leader>Ch" = "hover";
          "<leader>Cf" = "format";
          "<leader>Ca" = "code_action";
          "<leader>Cr" = "rename";
          "<leader>CD" = "declaration";
          "<leader>Cd" = "definition";
          "<leader>CR" = "references";
          "<leader>CI" = "implementation";
          "<leader>Cy" = "type_definition";
          "<leader>CWl" = "list_workspace_folders";
          "<leader>CWr" = "remove_workspace_folder";
          "<leader>CWa" = "add_workspace_folder";
        };
        extra =
          [
            (lib.mkIf (!config.plugins.conform-nvim.enable) {
              action.__raw = ''vim.lsp.buf.format'';
              mode = "v";
              key = "<leader>lf";
              options = {
                silent = true;
                buffer = false;
                desc = "Format selection";
              };
            })
          ]
          ++ lib.optionals (!config.plugins.glance.enable) [
            {
              action = "<CMD>PeekDefinition textDocument/definition<CR>";
              mode = "n";
              key = "<leader>lp";
              options = {
                desc = "Preview definition";
              };
            }
            {
              action = "<CMD>PeekDefinition textDocument/typeDefinition<CR>";
              mode = "n";
              key = "<leader>lP";
              options = {
                desc = "Preview type definition";
              };
            }
          ];
      };
      preConfig =
        # lua
        ''
          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            {border = 'rounded'}
          )

          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {border = 'rounded'}
          )
        '';
      postConfig =
        # lua
        ''
          vim.diagnostic.config {
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = " ",
              },
              numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
              },
            },
          }
        '';
    };
  };
  keymaps = lib.optionals config.plugins.conform-nvim.enable [
    {
      action.__raw = ''
        function(args)
         vim.cmd({cmd = 'Conform', args = args});
        end
      '';
      mode = "v";
      key = "<leader>lf";
      options = {
        silent = true;
        buffer = false;
        desc = "Format selection";
      };
    }
    {
      action.__raw = ''
        function()
          vim.cmd('Conform');
        end
      '';
      key = "<leader>lf";
      options = {
        silent = true;
        desc = "Format buffer";
      };
    }
  ];
}
