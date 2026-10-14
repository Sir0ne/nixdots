{
  pkgs,
  inputs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    pavucontrol
    piper
  ];

  services.ratbagd.enable = true;

  imports = [
    ../../modules/nixos
    #   Turn desktops into toggles down the line
    inputs.stylix.nixosModules.stylix
  ];

  desktops = {
    wayfire.enable = false;
    river.enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  stylix = {
    enable = true;
    icons = {
      package = pkgs.adwaita-icon-theme;
      light = "Adwaita";
      dark = "Adwaita";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/moonlight.yaml";
    image = ../../assets/backgrounds/Mountain.png;
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  programs.noisetorch.enable = true;
  systemd.user.services.pipewire.serviceConfig.Environment =
    "LADSPA_PATH=/tmp:/usr/lib64/ladspa:/usr/lib/ladspa:";
  systemd.user.services.pipewire-pulse.serviceConfig.Environment =
    "LADSPA_PATH=/tmp:/usr/lib64/ladspa:/usr/lib/ladspa:";

  modules = {
    steam.enable = true;
    syncthing.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      openmoji-color
      nasin-nanpa-helvetica
    ];
    fontconfig = {
      hinting.autohint = true;
      defaultFonts.emoji = [ "OpenMoji Color" ];
    };
  };

  services = {
    flatpak.enable = true;
  };

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  # Home manager packages and configs
  home-manager.users.goofy = {
    config.modules = {
      zen-browser.enable = true;
      kitty.enable = true;
      git.enable = true;
      nixcord.enable = true;
      nvim.enable = true;
    };
    config.home.packages = with pkgs; [
      r2modman
    ];
  };
}
