{
  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [];
    };
    byteCompileLua = rec {
      enable = true;
      nvimRuntime = enable;
      configs = enable;
      plugins = enable;
    };
  };
}
