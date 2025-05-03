{
  pkgs,
  lib,
  ...
}: {
  globals.mapleader = " ";

  diagnostic.settings = {
    update_in_insert = true;
    severity_sort = true;
    float = {
      border = "rounded";
      source = "always";
    };
  };

  opts = with lib; {
    # Enable relative line numbers
    number = true;
    relativenumber = true;

    # Set tabs to 2 spaces
    tabstop = 2;
    softtabstop = 2;
    showtabline = 0;
    expandtab = true;

    # Enable auto indenting and set it to spaces
    smartindent = true;
    shiftwidth = 2;

    # Enable text wrap
    wrap = true;
    breakindent = true;
    linebreak = true;

    # Enable incremental searching
    hlsearch = true;
    incsearch = true;

    # Better splitting
    splitbelow = true;
    splitright = true;

    # Enable mouse mode
    mouse = "a";

    # Enable ignorecase + smartcase for better searching
    ignorecase = true;
    smartcase = true; # Don't ignore case with capitals
    grepprg = "${getExe pkgs.ripgrep} --vimgrep";
    grepformat = "%f:%l:%c:%m";

    # Decrease updatetime
    updatetime = 50; # faster completion (4000ms default)

    # Set completeopt to have a better completion experience
    completeopt = [
      "menuone"
      "noselect"
      "noinsert"
    ];

    # Enable persistent undo history
    swapfile = false;
    autoread = true;
    backup = false;
    undofile = true;

    # Enable 24-bit colors
    termguicolors = true;

    # Enable the sign column to prevent the screen from jumping
    signcolumn = "yes";

    # Enable cursor line highlight
    cursorline = true; # Highlight the line where the cursor is located

    # Always keep 8 lines above/below cursor unless at start/end of file
    scrolloff = 10;

    # Place a column line
    # colorcolumn = "80";

    # Reduce which-key timeout to 10ms
    timeoutlen = 10;

    # Set encoding type
    encoding = "utf-8";
    fileencoding = "utf-8";
    cmdheight = 0;
    showmode = false;
  };

  extraPackages = with pkgs; [
    xclip
  ];
}
