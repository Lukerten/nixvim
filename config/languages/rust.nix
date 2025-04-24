{
  plugins = {
    # Extra Plugin Bacon
    bacon.enable = true;

    # Extra PLugin Rustacean
    rustaceanvim = {
      enable = true;
      settings = {
        tools.enable_clippy = true;
        server = {
          default_settings = {
            inlayHints.lifetimeElisionHints.enable = "always";
            rust-analyzer = {
              cargo = {allFeatures = true;};
              check = {command = "clippy";};
              files = {excludeDirs = ["target" ".git" ".cargo" ".github" ".direnv"];};
            };
          };
          dap.adapters.lldb = {
            type = "server";
            port = "${''$''}{port}";
            executable = {
              command = "codelldb";
              args = ["--port" "${''$''}{port}"];
            };
          };
        };
      };
    };
  };
}
