{
  plugins = {
    none-ls.sources.formatting.prettier.enable = true;
    conform-nvim.settings.formatters_by_ft.html = {
      __unkeyed-1 = "prettierd";
      __unkeyed-2 = "prettier";
      stop_after_first = true;
    };
  };
}
