# Wayfire desktop environment for NixOS system
# Home manager -> modules/hm/wayfire/... + modules

{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.desktops.wayfire;
in
{
  options.desktops.wayfire = {
    enable = mkEnableOption "Wayfire";
  };
  config = mkIf cfg.enable {

    # NixOS configuration for Wayfire
    environment.systemPackages = with pkgs; [
      tuigreet
    ];

    programs.wayfire = {
      enable = true;
      xwayland.enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };

    # if off: hm systemd -> true
    programs.uwsm = {
      enable = true;
      waylandCompositors.wayfire = {
        prettyName = "Wayfire";
        comment = "Wayfire managed under UWSM";
        binPath = "/run/current-system/sw/bin/wayfire";
      };
    };

    # reminder: doesnt work, try again later.
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet";
        user = "greeter";
      };
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };

    home-manager.users.goofy = {
      config.modules = {
        wayfire.enable = true;
        fuzzel.enable = true;
        waybar.enable = true;
      };
    };
  };
}
