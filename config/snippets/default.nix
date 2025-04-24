{
  plugins = {
    friendly-snippets.enable = true;
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
    };
    nvim-snippets = {
      enable = false;
      settings = {
        create_autocmd = true;
        create_cmp_source = true;
        friendly_snippets = true;
        ignored_filetypes = [];
        global_snippets = [
          "all"
        ];
        search_paths = [
          {
            __raw = "vim.fn.stdpath('config') .. '/snippets'";
          }
        ];
      };
    };
  };
}
