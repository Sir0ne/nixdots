{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.kitty;
in
{
  options.modules.river = {
    enable = mkEnableOption "river";
  };
  config = mkIf cfg.enable {
    wayland.windowManager.river = {
      enable = true;
      systemd.enable = false;
      settings = {
        border-width = 2;
        declare-mode = [
          "locked"
          "normal"
          "passthrough"
        ];
        input = {
          pointer-foo-bar = {
            accel-profile = "flat";
            events = true;
            pointer-accel = -0.3;
            tap = false;
          };
        };
        map = {
          normal = {
            "Alt Q" = "close";
          };
        };
        rule-add = {
          "-app-id" = {
            "'bar'" = "csd";
            "'float*'" = {
              "-title" = {
                "'foo'" = "float";
              };
            };
          };
        };
        set-cursor-warp = "on-output-change";
        set-repeat = "50 300";
        spawn = [
          "firefox"
          "'foot -a terminal'"
        ];

      };
    };
  };
}
