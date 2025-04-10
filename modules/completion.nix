{
  lib,
  config,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.autocomplete;
  debugEnabled = config.vim.debug.enable;

  builtSources =
    concatMapStringsSep
    "\n"
    (n: "{ name = '${n}'},")
    (attrNames cfg.cmp.sources);

  builtMaps =
    concatStringsSep
    "\n"
    (mapAttrsToList
      (n: v:
        if v == null
        then ""
        else "${n} = '${v}',")
      cfg.cmp.sources);

  dagPlacement = nvim.dag.entryAnywhere;
in {
  options.vim = {
    autocomplete = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable autocomplete";
      };
      cmp.enable = mkEnableOption "enable blink-cmp";
      copilot.enable = mkEnableOption "enable copilot";
      snippets.enable = mkEnableOption "enable snippets";
    };
  };

  config.vim = mkIf cfg.enable (mkMerge [
    (mkIf cfg.snippets.enable {
      startPlugins = ["vim-vsnip"];
    })
    (mkIf cfg.copilot.enable {
      startPlugins = [
        "copilot"
        "copilot-chat"
      ];
      luaConfigRC.copilot =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("copilot").setup({
            panel = { enabled = true },
            suggestion = {
              enabled = true,
              auto_trigger = false,
              keymap = {
                accept = "<C-y>",
                next = "<C-j>",
              },
            },
          })


          require("CopilotChat").setup({
            model = "gpt-4o",
            context = "buffers",
            window = {
              layout = "vertical",
              title = "Copilot Chat",
            },
          })

          vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>CopilotChatToggle<cr>', { desc = "CopilotChat - Toggle" })
          vim.keymap.set({ 'n', 'v' }, '<leader>cce', '<cmd>CopilotChatExplain<cr>', { desc = "CopilotChat - Explain code" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ccg', '<cmd>CopilotChatCommit<cr>', { desc = "CopilotChat - Write commit message for the change" })
          vim.keymap.set({ 'n', 'v' }, '<leader>cct', '<cmd>CopilotChatTests<cr>', { desc = "CopilotChat - Generate tests" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ccf', '<cmd>CopilotChatFix<cr>', { desc = "CopilotChat - Fix diagnostic" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ccr', '<cmd>CopilotChatReset<cr>', { desc = "CopilotChat - Reset chat history and clear buffer" })
          vim.keymap.set({ 'n', 'v' }, '<leader>cco', '<cmd>CopilotChatOptimize<cr>', { desc = "CopilotChat - Optimize selected code" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ccd', '<cmd>CopilotChatDocs<cr>', { desc = "CopilotChat - Add docs on selected code" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ccp', '<cmd>CopilotChatReview<cr>', { desc = "CopilotChat - Review selected code" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ccs', '<cmd>CopilotChatStop<cr>', { desc = "CopilotChat - Stop current window output" })
          vim.keymap.set('n', '<leader>ccp', function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
          end, { desc = 'CopilotChat - Prompt actions' })
          vim.keymap.set("n", "<leader>ccq", function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
          end, { desc = 'CopilotChat - Quick chat' })
        '';
    })
    (mkIf cfg.cmp.enable {
      startPlugins = [
        "blink-cmp"
        "blink-cmp-copilot"
      ];

      luaConfigRC.completion =
        nvim.dag.entryAnywhere
        # lua
        ''
          require("blink.cmp").setup({
            keymap = {
              preset = 'none',
              ['<Tab>'] = {'snippet_forward','select_next', 'fallback'},
              ['<C-Tab>'] = {'snippet_backward','select_next', 'fallback'},
              ['<C-s>'] = { 'show_signature', 'fallback'},
              ['<C-e>'] = {},
              ['<C-Space>'] = { 'show_documentation', 'fallback'},
              ['<Up>'] = { 'scroll_documentation_up', 'fallback' },
              ['<Down>'] = { 'scroll_documentation_down', 'fallback' },
              ['<CR>'] = { 'accept', 'fallback' },
              ['<C-a>'] = { 'show'},
            },
            completion = {
              list = {
                max_items = 200,
                selection = {
                  preselect = true,
                  auto_insert = true,
                },
                cycle = {
                  from_bottom = true,
                  from_top = true,
                },
              },
              documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = {
                  border = "rounded",
                },
              },
              menu = {
                border = "rounded",
              },
            },
            fuzzy = {
              implementation = 'prefer_rust',
            },
            signature = { enabled = true },
            sources = {
              default = { "lsp", "path", "snippets", "buffer", "copilot" },
              providers = {
                copilot = {
                  name = "copilot",
                  module = "blink-cmp-copilot",
                  score_offset = 100,
                  async = true,
                },
              },
            },
          })
        '';
    })
  ]);
}
