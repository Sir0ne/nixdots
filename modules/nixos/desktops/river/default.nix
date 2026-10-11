{
  pkgs,
  inputs,
  lib,
  ...
}:
with lib;
let
  cfg = config.desktops.river;
in
{
  options.dekstops.river = {
    enable = mkEnableOption "River";
  };

  imports = [
    (import "${inputs.river-next}/river-module.nix")
  ];

  config = mkIf cfg.enable {

    programs.river-next = {
      enable = true;

      # Currently configured: beansprout,
      windowManagers = [ "beansprout" ];
      xwayland.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.wlr.enable = true;

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "wlr";
      XDG_SESSION_DESKTOP = "river";
      SDL_VIDEODRIVER = "wayland,x11";
      QT_QPA_PLATFORM = "wayland";
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
      displayManager.ly.enable = true;
    };

    home-manager.users.goofy = {
      config.modules = {
        river.enable = true;
        fuzzel.enable = true;
      };
    };
  };
}
