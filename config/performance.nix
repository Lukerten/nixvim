{
  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "copilot.lua"
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
