{
  plugins = {
    conform-nvim.settings.formatters_by_ft.kotlin = ["ktlint"];
    lsp.servers.kotlin_language_server.enable = true;
    none-ls.sources.formatting.ktlint.enable = true;
  };
}
