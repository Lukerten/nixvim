{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utils.copilot;
in {
  options.vim.utils.copilot = {
    enable = mkEnableOption "chat";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = [
      "copilot"
      "copilot-cmp"
      "copilot-chat"
    ];

    vim.luaConfigRC.chat =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require("copilot_cmp").setup()
        require("copilot").setup({
          panel = { enabled = false },
          suggestion = {
            enabled = false,
            keymap = {
              accept = "<C-j>",
            },
          },
        })

        require("CopilotChat").setup({
          context = "buffers",
          window = {
            layout = "vertical",
            title = "Copilot Chat",
          },
        })

        function _G.copilot_chat()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end

        function _G.copilot_chat_action()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end

        vim.keymap.set({ 'n', 'v' }, '<leader>Co', '<cmd>CopilotChatToggle<cr>', { silent = true, noremap = true, desc = "CopilotChat - Toggle" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Ce', '<cmd>CopilotChatExplain<cr>', { silent = true, noremap = true, desc = "CopilotChat - Explain code" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cg', '<cmd>CopilotChatCommit<cr>', { silent = true, noremap = true, desc = "CopilotChat - Write commit message for the change" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Ct', '<cmd>CopilotChatTests<cr>', { silent = true, noremap = true, desc = "CopilotChat - Generate tests" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cf', '<cmd>CopilotChatFixDiagnostic<cr>', { silent = true, noremap = true, desc = "CopilotChat - Fix diagnostic" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cr', '<cmd>CopilotChatReset<cr>', { silent = true, noremap = true, desc = "CopilotChat - Reset chat history and clear buffer" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Co', '<cmd>CopilotChatOptimize<cr>', { silent = true, noremap = true, desc = "CopilotChat - Optimize selected code" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cd', '<cmd>CopilotChatDocs<cr>', { silent = true, noremap = true, desc = "CopilotChat - Add docs on selected code" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cp', '<cmd>CopilotChatReview<cr>', { silent = true, noremap = true, desc = "CopilotChat - Review selected code" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cs', '<cmd>CopilotChatStop<cr>', { silent = true, noremap = true, desc = "CopilotChat - Stop current window output" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Ca', '<cmd>lua copilot_chat_action()<cr>', { silent = true, noremap = true, desc = "CopilotChat - Select action" })
        vim.keymap.set({ 'n', 'v' }, '<leader>Cc', '<cmd>lua copilot_chat()<cr>', { silent = true, noremap = true, desc = "CopilotChat - Ask a question" })
        vim.keymap.set({ 'n', 'v' }, '<leader>a', '<cmd>lua copilot_chat()<cr>', { silent = true, noremap = true, desc = " Ask Copilot" })
      '';
  };
}
