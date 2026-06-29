{ pkgs, config, ... }: {

  imports = [
    ../../modules/nixos/steam
    ../../modules/nixos/syncthing
  ];

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

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    uwsm = {
      enable = true;
      waylandCompositors = {
        wayfire = {
          prettyName = "Wayfire (UWSM)";
          comment = "Wayfire";
          binPath = "${pkgs.wayfire}/bin/wayfire";
        };
      };
    };
    fish.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    flatpak.enable = true;
  };

  networking.wireless.iwd.enable = true;

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

  home-manager.users.goofy = {
    config.modules = {
      zen-browser.enable = true;
      fuzzel.enable = true;
      kitty.enable = true;
      git.enable = true;
      vesktop.enable = true;
      stylix.enable = true;
      waybar.enable = true;
      hyprland.enable = true;
      retroarch.enable = true;
      nvim.enable = true;
      prismlauncher.enable = true;
    };
  };
}
