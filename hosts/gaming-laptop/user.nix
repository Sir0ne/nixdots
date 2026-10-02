{ pkgs, inputs, config, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ../../modules/nixos/steam
  ];

  modules = {
    steam.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      openmoji-color
    ];
    fontconfig = {
      hinting.autohint = true;
      defaultFonts.emoji = [ "OpenMoji Color" ];
    };
  };

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

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
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

    displayManager.ly = {
      enable = true;
    };
  };

  networking.wireless.iwd.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      
      powerManagement = {
        enable = true;
        finegrained = false;
      };

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
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
      grimoire.enable = true;
      git.enable = true;
      nixcord.enable = true;
      waybar.enable = true;
      hyprland.enable = true;
    };
  };
}
