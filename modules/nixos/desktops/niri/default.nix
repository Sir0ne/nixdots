{ pkgs, ... }: {
  programs.niri.enable = true;

  programs.uwsm = {
    enable = true;

    waylandCompositors.niri = {
      prettyName = "Niri";
      binPath = "${pkgs.niri}/bin/niri";
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
    displayManager.ly.enable = true;
  };

  home-manager.users.goofy = {
    config.modules = {
      fuzzel.enable = true;
      waybar.enable = true;
    };
  }
}
