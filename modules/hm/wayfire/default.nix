{
  lib,
  config,
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
      wf-shell.enable = true;

      settings = {
        core = {
          plugins = [
            "alpha"
            "animate"
            "autostart"
            "command"
            "cube"
            "expo"
            "grid"
            "move"
            "place"
            "resize"
            "switcher"
            "vswitch"
            "window-rules"
            "wobbly"
            "zoom"
          ];
        };
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
    home.packages = with pkgs; [
      wcm
      wayfirePlugins.wayfire-plugins-extra
    ];
  };
}
