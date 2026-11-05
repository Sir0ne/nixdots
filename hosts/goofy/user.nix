{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [ inputs.grimoire.overlays.default ];

  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    pavucontrol
    easyeffects
    mpv
    grimoire
    winetricks
    wineWow64Packages.waylandFull
  ];

  imports = [
    ../../modules/nixos
    inputs.stylix.nixosModules.stylix
  ];
  # Desktops modules
  desktops.river.enable = true;

  # Rice
  stylix = {
    enable = true;
    icons = {
      package = pkgs.papirus-icon-theme;
      light = "Papirus";
      dark = "Papirus";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    image = ../../assets/backgrounds/Mountain.png;
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  # NixOS sys modules
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
  boot = {
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
    consoleLogLevel = 3;

    loader.timeout = lib.mkForce 0;
  };

  # Home manager packages and modules
  home-manager.users.goofy = {
    config.modules = {
      zen-browser.enable = true;
      fish.enable = true;
      kitty.enable = true;
      git.enable = true;
      concord.enable = true;
      nvim.enable = true;
      fastfetch.enable = true;
      qobine-tui.enable = true;
      obs.enable = true;
    };
    config.home.packages = with pkgs; [
      prismlauncher
      kew
      tuxedo
      blender
    ];
  };
}
