{
  plugins = {
    conform-nvim.settings.formatters_by_ft.cpp = ["clang_format"];
    none-ls.sources.formatting.clang_format.enable = true;
    lsp.servers.clangd.enable = true;
  };
}
