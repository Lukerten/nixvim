{
  plugins.lean = {
    enable = true;
    settings = {
      lsp.enable = true;
      ft = {
        default = "lean";
        nomodifiable = ["_target"];
      };
      abbreviations = {
        enable = true;
        extra = {
          wknight = "♘";
        };
      };
      mappings = false;
      infoview = {
        horizontal_position = "top";
        separate_tab = true;
        indicators = "always";
      };
      progress_bars.enable = false;
      stderr.on_lines.__raw = "function(lines) vim.notify(lines) end";
    };
  };
}
