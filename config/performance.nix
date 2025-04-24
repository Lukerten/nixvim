{
  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "copilot.lua"
        "nvim-treesitter"
        "hmts.nvim"
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
