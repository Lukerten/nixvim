{
  diagnostic.settings.virtual_text = false;

  plugins.tiny-inline-diagnostic = {
    enable = true;
    settings = {
      preset = "classic";
      virt_texts.priority = 2048;
      multilines.enabled = true;
      options.use_icons_from_diagnostic = true;
    };
  };
}
