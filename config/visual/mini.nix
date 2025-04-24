{
  plugins.mini = {
    enable = true;
    modules = {
      ai = {};
      diff.view = {
        style = "sign";
        signs = {
          add = "│";
          change = "│";
          delete = "-";
        };
      };
    };
  };
}
