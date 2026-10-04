{ ... }: {
  services.mako.settings = {
    sort = "-time";
    layer = "overlay";
    width = 300;
    height = 110;
    border-size = 2;
    border-radius = 15;
    icons = 0;
    max-icon-size = 64;
    default-timeout = 5000;
    ignore-timeout = 1;
    font = "monospace 14";
  };
}
