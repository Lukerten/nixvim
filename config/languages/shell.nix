{pkgs, ...}: {
  plugins = {
    conform-nvim.settings.formatters_by_ft.bash = ["shfmt"];
    conform-nvim.settings.formatters_by_ft.sh = ["shfmt"];
    lsp.servers = {
      bashls.enable = true;
      nushell.enable = true;
      fish_lsp.enable = true;
    };
  };
  extraPackages = with pkgs; [shfmt];
}
