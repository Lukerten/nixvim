{
  description = "MerrinX Neovim Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # LSP plugins
    plugins-fidget = {
      url = "github:j-hui/fidget.nvim";
      flake = false;
    };
    plugins-nvim-lightbulb = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };
    plugins-nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    plugins-lspkind = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };
    plugins-null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    plugins-lsp-signature = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };
    plugins-trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };

    # LSP tools
    plugins-crates-nvim = {
      url = "github:Saecki/crates.nvim";
      flake = false;
    };
    plugins-nvim-jdtls = {
      url = "github:mfussenegger/nvim-jdtls";
      flake = false;
    };
    plugins-nvim-metals = {
      url = "github:scalameta/nvim-metals";
      flake = false;
    };
    plugins-rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    plugins-sqls-nvim = {
      url = "github:nanotee/sqls.nvim";
      flake = false;
    };

    # Debug
    plugins-nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    plugins-nvim-dap-ui = {
      url = "github:rcarriga/nvim-dap-ui";
      flake = false;
    };
    plugins-nvim-dap-virtual-text = {
      url = "github:theHamsta/nvim-dap-virtual-text";
      flake = false;
    };
    plugins-nvim-nio = {
      url = "github:nvim-neotest/nvim-nio";
      flake = false;
    };

    # Telescope
    plugins-fzf-lua = {
      url = "github:ibhagwan/fzf-lua";
      flake = false;
    };

    # Autocompletes
    plugins-blink-cmp = {
      url = "github:Saghen/blink.cmp";
      flake = false;
    };
    plugins-blink-cmp-copilot = {
      url = "github:giuxtaposition/blink-cmp-copilot";
      flake = false;
    };
    # snippets
    plugins-vim-vsnip = {
      url = "github:hrsh7th/vim-vsnip";
      flake = false;
    };

    # Copilot
    plugins-copilot = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };
    plugins-copilot-chat = {
      url = "github:CopilotC-Nvim/CopilotChat.nvim";
      flake = false;
    };

    # Markdown
    plugins-glow-nvim = {
      url = "github:ellisonleao/glow.nvim";
      flake = false;
    };
    plugins-markdown-preview = {
      url = "github:iamcco/markdown-preview.nvim";
      flake = false;
    };

    # Git
    plugins-gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    plugins-lazygit = {
      url = "github:kdheepak/lazygit.nvim";
      flake = false;
    };

    # Theme
    plugins-theme = {
      url = "github:catppuccin/nvim";
      flake = false;
    };

    # Visuals
    plugins-nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    plugins-indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    plugins-leap = {
      url = "github:ggandor/leap.nvim";
      flake = false;
    };
    plugins-lualine = {
      url = "github:hoob3rt/lualine.nvim";
      flake = false;
    };
    plugins-noice = {
      url = "github:folke/noice.nvim";
      flake = false;
    };
    plugins-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    plugins-nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    plugins-ranger = {
      url = "github:kelly-lin/ranger.nvim";
      flake = false;
    };
    plugins-todo = {
      url = "github:folke/todo-comments.nvim";
      flake = false;
    };
    plugins-nvim-tree = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    plugins-alpha = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };

    #Orgmode
    plugins-orgmode = {
      url = "github:nvim-orgmode/orgmode";
      flake = false;
    };
    plugins-org-roam = {
      url = "github:chipsenkbeil/org-roam.nvim";
      flake = false;
    };

    # Key binding help
    plugins-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };

    # Core
    plugins-plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    plugins-nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    rawPlugins = nvimLib.plugins.fromInputs inputs "plugins-";

    neovimConfiguration = {modules ? [], ...} @ args:
      import ./modules
      (args // {modules = [{config.build.rawPlugins = rawPlugins;}] ++ modules;});

    nvimBin = pkg: "${pkg}/bin/nvim";

    buildPkg = pkgs: modules: (neovimConfiguration {
      inherit pkgs modules;
    });

    nvimLib = (import ./modules/lib/stdlib-extended.nix nixpkgs.lib).nvim;
    mainConfig = {
      config = {
        build.viAlias = false;
        build.vimAlias = true;
        vim = {
          autocomplete = {
            enable = true;
            cmp = {
              enable = true;
              type = "nvim-cmp";
            };
            copilot.enable = true;
            snippets.enable = true;
          };
          fzf.enable = true;
          git.enable = true;
          filetree.enable = true;
          keys = {
            enable = true;
            whichKey.enable = true;
          };
          languages = {
            enableLSP = true;
            enableDebug = true;
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            clang.enable = true;
            css.enable = true;
            haskell.enable = true;
            html.enable = true;
            java.enable = true;
            kotlin.enable = true;
            lua.enable = true;
            markdown.enable = true;
            nix.enable = true;
            org.enable = true;
            python.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };
            scala.enable = true;
            bash.enable = true;
            sql.enable = true;
            tailwind.enable = true;
            ts.enable = true;
            vue.enable = true;
            xml.enable = true;
          };
          lsp = {
            formatOnSave = false;
            fidget.enable = true;
            lightbulb.enable = true;
            lspkind.enable = true;
            lspSignature.enable = true;
            trouble.enable = true;
          };
          debug = {
            virtualText.enable = true;
            ui.enable = true;
          };
          theme.enable = true;
          visuals = {
            enable = true;
            autopairs.enable = true;
            alpha.enable = true;
            indentBlankline = {
              enable = true;
            };
            leap.enable = true;
            lualine = {
              enable = true;
              theme = "auto";
            };
            noice = {
              enable = true;
            };
            nvimWebDevicons.enable = true;
            ranger.enable = true;
            todo.enable = true;
          };
          terminal = {
            enable = true;
            simple.enable = true;
            float.enable = true;
            project.enable = true;
            new_tab.enable = true;
          };
        };
      };
    };
  in
    {
      lib = {
        nvim = nvimLib;
        inherit neovimConfiguration;
      };

      overlays.default = _: prev: {
        inherit neovimConfiguration;
        neovim = buildPkg prev [mainConfig];
      };
    }
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (_: _: {
            rnix-lsp = inputs.rnix-lsp.defaultPackage.${system};
            nil = inputs.nil.packages.${system}.default;
          })
        ];
      };

      neovimPkg = buildPkg pkgs [mainConfig];

      devPkg = buildPkg pkgs [mainConfig {config.vim.languages.html.enable = pkgs.lib.mkForce true;}];
    in {
      apps =
        rec {
          neovim = {
            type = "app";
            program = nvimBin neovimPkg;
          };
          default = neovim;
        }
        // pkgs.lib.optionalAttrs (!(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])) {};

      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          devPkg
          pkgs.alejandra
          pkgs.nodejs-slim
        ];
      };

      packages =
        {
          default = neovimPkg;
          neovim = neovimPkg;
        }
        // pkgs.lib.optionalAttrs (!(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])) {};
      defaultPackage = neovimPkg;
    }));
}
