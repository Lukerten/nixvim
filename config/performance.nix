{
  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "copilot.lua"
        "nvim-treesitter"
        "hmts.nvim"
        "nvim-tree.lua"
        "conform.nvim"
        "typst-preview.nvim"
        "mini.nvim"
      ];
    };
    byteCompileLua = rec {
      enable = true;
      nvimRuntime = enable;
      configs = enable;
      plugins = enable;
    };
  };
}
