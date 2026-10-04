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

  imports = [
    ./waybar.nix
    ./wcm.nix
    ./mako.nix
    ./packages.nix
  ];

  options.modules.wayfire = {
    enable = mkEnableOption "Wayfire";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    wayland.windowManager.wayfire = {
      enable = true;
      package = null;
      systemd.enable = false;
      wf-shell.enable = true;

      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };
}
