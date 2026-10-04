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
    wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
    
    fish.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors = {
        wayfire = {
          prettyName = "Wayfire";
          comment = "Wayfire compositor managed by UWSM";
          binPath = "/run/current-system/bin/wayfire";
        };
      };
    };
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

  boot.kernel.sysctl = { 
    "vm.max_map_count" = 2147483642; 
  };

  networking.wireless.iwd.enable = true;
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];  


  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      
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
      wayfire.enable = true;
    };
  };
}
