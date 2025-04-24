{
  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "copilot.lua"
        "nvim-treesitter"
        "hmts.nvim"
        "nvim-tree.lua"
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
