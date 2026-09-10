{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.wayfire;
in
{
  options.modules.wayfire = {
    enable = mkEnableOption "Wayfire";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      adwaita-icon-theme
      slurp
      grim
      wf-recorder
    ];

    fonts.fontconfig.enable = true;

    wayland.windowManager.wayfire = {
      enable = true;
      package = null;
      wf-shell.enable = true;

      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];

      settings = {
        "output:HDMI-A-1" = {
          mode = "1920x1080@180000";
          position = "0,0";
          transform = "normal";
          scale = "1.000000";
        };

        "output:DP-2" = {
          mode = "1920x1080@60000";
          position = "1920,0";
          transform = "normal";
          scale = "1.000000";
        };

        core.plugins = "autostart command move resize scale animate cube wayfire-shell wm-actions wlr-screencopy";

        command = {
          binding_close = "<super> KEY_Q";
          command_close = "wayfire-close";
        };

        cube = {
          active = "<super> <alt> btn_left";
          rotate_left = "<super> <alt> KEY_LEFT";
          rotate_right = "<super> <alt> KEY_RIGHT";
        };

        wayfire-shell = {
          toggle_menu = "<super>";
        };

        wm-actions = {
          toggle_fullscreen = "<super> KEY_F";
        };
      };
    };
  };
}
