{
  pkgs,
  inputs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    pavucontrol
  ];

  imports = [
    ../../modules/nixos/steam
    ../../modules/nixos/syncthing

#   Turn desktops into toggles down the line
    ../../modules/nixos/desktops/wayfire
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    icons = {
      package = pkgs.adwaita-icon-theme;
      light = "Adwaita";
      dark = "Adwaita";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ../../assets/backgrounds/Mountain.png;
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

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

  # Services [ Graphics, Audio, Video, Networking ]
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    flatpak.enable = true;
  };

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  # Home manager packages and configs
  home-manager.users.goofy = {
    config.modules = {
      zen-browser.enable = true;
      kitty.enable = true;
      git.enable = true;
      nixcord.enable = true;
      retroarch.enable = true;
      nvim.enable = true;
      prismlauncher.enable = true;
      grimoire.enable = true;
      wayfire.enable = true;
      pcsx.enable = true;
      waybar.enable = true;
      fuzzel.enable = true;
    };
  };
}
