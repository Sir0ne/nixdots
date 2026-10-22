{
  pkgs,
  inputs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    pavucontrol
    easyeffects
    mpv
  ];

  imports = [
    ../../modules/nixos
    #   Turn desktops into toggles down the line
    inputs.stylix.nixosModules.stylix
  ];

  desktops.river.enable = true;

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

  # Home manager packages and modules
  home-manager.users.goofy = {
    config.modules = {
      zen-browser.enable = true;
      kitty.enable = true;
      git.enable = true;
      concord.enable = true;
      nvim.enable = true;
      fastfetch.enable = true;
    };
    config.home.packages = with pkgs; [
      r2modman
      prismlauncher
      osu-lazer-bin
      kew
    ];
  };
}
