{
  plugins = {
    conform-nvim.settings.formatters_by_ft.go = ["golines"];
    lsp.servers.gopls.enable = true;
    none-ls.sources.formatting.golines.enable = true;
  };
}
