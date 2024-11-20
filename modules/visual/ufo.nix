{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visual.ufo;
in {
  options.vim.visual.ufo = {
    enable = mkEnableOption "Todo highlights [nvim-todo]";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["ufo" "async" "statuscolumn"];
    vim.luaConfigRC.todo =
      nvim.dag.entryAnywhere #lua
      ''
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        local handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local totalLines = vim.api.nvim_buf_line_count(0)
          local foldedLines = endLnum - lnum
          local suffix = ("     ... %d lines ommitted"):format(foldedLines, foldedLines / totalLines * 100)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          local rAlignAppndx =
            math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
          suffix = (" "):rep(rAlignAppndx) .. suffix
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end

        local builtin = require("statuscol.builtin")
        require("statuscol").setup(
          {
            relculright = true,
            segments = {
              {text = {"%s"}, click = "v:lua.ScSa"},
              {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
              {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
            }
          }
        )
        require('ufo').setup({
          fold_virt_text_handler = handler,
          open_fold_hl_timeout = 400,
          close_fold_kinds = { "imports", "comment" },
          preview = {
            win_config = {
              border = { "", "─", "", "", "", "─", "", "" },
              winblend = 0,
            },
            mappings = {
              scrollU = "<C-u>",
              scrollD = "<C-d>",
              jumpTop = "[",
              jumpBot = "]",
            },
          },
        })
        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
        vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      '';
  };
}
