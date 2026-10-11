{ pkgs, inputs, ... }: {

  imports = [
    (import "${inputs.river-next}/river-module.nix")
  ];

  programs.river-next = {
    enable = true;
    windowManagers = [ "beansprout" ];
    xwayland.enable = true;
  };

  programs.uwsm = {
    enable = true;

    waylandCompositors.river = {
      prettyName = "River";
      comment = "River compositor managed under UWSM";
      binPath = "${pkgs.river}/bin/river";
    };
  };

  xdg.portal.enable = true;

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
      waybar.enable = true;
    };
    config.home.packages = with pkgs; [
      foot
    ];
  };
}
