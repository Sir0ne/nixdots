{ pkgs, inputs, ... }: {

  imports = [
    (import "${inputs.river-next}/river-module.nix")
  ];

  programs.river-next = {
    enable = true;
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
}
