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
    plugins-telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    plugins-telescope-project = {
      url = "github:nvim-telescope/telescope-project.nvim";
      flake = false;
    };

    # Autocompletes
    plugins-nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    plugins-cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    plugins-cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    plugins-cmp-vsnip = {
      url = "github:hrsh7th/cmp-vsnip";
      flake = false;
    };
    plugins-cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    plugins-cmp-treesitter = {
      url = "github:ray-x/cmp-treesitter";
      flake = false;
    };
    plugins-cmp-dap = {
      url = "github:rcarriga/cmp-dap";
      flake = false;
    };
    plugins-cmp-nvim-lsp-signature-help = {
      url = "github:hrsh7th/cmp-nvim-lsp-signature-help";
      flake = false;
    };
    plugins-cmp-nvim-lsp-document-symbol = {
      url = "github:hrsh7th/cmp-nvim-lsp-document-symbol";
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
    plugins-copilot-cmp = {
      url = "github:zbirenbaum/copilot-cmp";
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
    plugins-octo-nvim = {
      url = "github:pwntester/octo.nvim";
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
    plugins-undotree = {
      url = "github:jiaoshijie/undotree";
      flake = false;
    };

    # Notes
    plugins-obsidian = {
      url = "github:epwalsh/obsidian.nvim";
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
    plugins-ranger = {
      url = "github:kelly-lin/ranger.nvim";
      flake = false;
    };
    plugins-theme = {
      url = "github:EdenEast/nightfox.nvim";
      flake = false;
    };
    plugins-todo = {
      url = "github:folke/todo-comments.nvim";
      flake = false;
    };
    plugins-nvim-tree-lua = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };
    plugins-alpha-nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };
    plugins-vimwiki = {
      url = "github:vimwiki/vimwiki";
      flake = false;
    };
    plugins-kommentary = {
      url = "github:b3nj5m1n/kommentary";
      flake = false;
    };
    plugins-bufferline = {
      url = "github:akinsho/nvim-bufferline.lua";
      flake = false;
    };
    plugins-bbye = {
      url = "github:moll/vim-bbye";
      flake = false;
    };
    plugins-remote-nvim = {
      url = "github:amitds1997/remote-nvim.nvim";
      flake = false;
    };

    # Key binding help
    plugins-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    plugins-plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    plugins-nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    plugins-nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
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

        # Autocompletion
        vim.autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };

        # LSP
        vim.lsp = {
          formatOnSave = false;
          fidget.enable = true;
          lightbulb.enable = true;
          lspkind.enable = true;
          lspSignature.enable = true;
          trouble.enable = true;
        };

        # Languages
        vim.languages = {
          enableLSP = true;
          enableDebug = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Enable Language Features for:
          clang.enable = true;
          css.enable = true;
          dhall.enable = true;
          golang.enable = true;
          haskell.enable = true;
          html.enable = true;
          java.enable = true;
          kotlin.enable = true;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python.enable = true;
          scala.enable = true;
          shell.enable = true;
          sql.enable = true;
          tailwind.enable = true;
          ts.enable = true;
          vue.enable = true;
          xml.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
        };
        vim.utils.enable = true;
        vim.visual.enable = true;
      };
    };
  in
    {
      lib = {
        nvim = nvimLib;
        inherit neovimConfiguration;
      };

      overlays.default = _final: prev: {
        inherit neovimConfiguration;
        neovim = buildPkg prev [mainConfig];
      };
    }
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (_final: _prev: {
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
        // pkgs.lib.optionalAttrs (!(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])) {
        };

      devShells.default = pkgs.mkShell {nativeBuildInputs = [devPkg];};

      packages =
        {
          default = neovimPkg;
          neovim = neovimPkg;
        }
        // pkgs.lib.optionalAttrs (!(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])) {
        };
      defaultPackage = neovimPkg;
    }));
}
