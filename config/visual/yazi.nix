{
  config,
  lib,
  ...
}: {
  plugins.yazi = {
    enable = true;

    lazyLoad = {
      settings = {
        cmd = [
          "Yazi"
        ];
      };
    };
  };

  keymaps = lib.optionals config.plugins.yazi.enable [
    {
      mode = "n";
      key = "<leader>E";
      action = "<CMD>Yazi<CR>";
      options = {
        desc = "Yazi (current file)";
      };
    }
  ];
}
