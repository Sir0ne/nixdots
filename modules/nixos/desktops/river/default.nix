{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    pkgs.river
    pkgs.river-bsp-layout
  ];

  programs.uwsm.enable = true;

  services.displayManager.sessionPackages = [ pkgs.river ];

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
    displayManager.enable = true;
  };

  home-manager.users.goofy = {
    config.modules = {
      wayfire.enable = true;
      fuzzel.enable = true;
      waybar.enable = true;
    };
  };
}
