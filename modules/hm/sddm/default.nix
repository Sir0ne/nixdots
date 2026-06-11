{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.sddm;
in {
  options.modules.sddm = {enable = mkEnableOption "sddm";};
  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
      })
    ];

    services.displayManager = {
      sessionPackages = [];
      sddm = {
        enable = true;
        theme = "cattpuccin-mocha-mauve";
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        settings = {
          general = {
            DisplayServer = "wayland";
            GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,KWIN_FORCE_SW_CURSOR=1";
          };
        };
      };
    };
  };
}
