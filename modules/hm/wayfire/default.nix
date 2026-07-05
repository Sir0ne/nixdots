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
    wayland.windowManager.wayfire = {
      enable = true;
      systemd.enable = false;
      wf-shell.enable = false;

      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];

      settings = {
        core.plugins = "autostart command move resize scale animate";
        command = {
          binding_close = "<super> KEY_Q";
          command_close = "wayfire-close";
        };
        cube = {
          active = "<super> <alt> btn_left";
          rotate_left = "<super> <alt> KEY_LEFT";
          rotate_right = "<super> <alt> KEY_RIGHT";
        };
      };
    };
  };
}
