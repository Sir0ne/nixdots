{
  pkgs,
  config,
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

  programs = {
    wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };

    hyprland = {
      enable = true;
      withUWSM = true;
    };

    uwsm = {
      enable = true;

      waylandCompositors = {
        wayfire = {
          prettyName = "Wayfire";
          comment = "Modular 3D Wayland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/wayfire";
        };
      };
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

    displayManager = {
      regreet = {
        enable = true;
        cageArgs = [
          "-s"
          "-m"
          "last"
        ];
      };
    };

    flatpak.enable = true;
  };

  xdg.portal.config.wayfire = {
    default = [
      "wlr"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Inhibit" = [ "none" ];
  };

  xdg.portal.wlr.settings = {
    screencast = {
      output_name = "HDMI-A-1";
      max_fps = 30;
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
      force_mod_linear = true;
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (old: {
        version = "0.8.4";
        src = final.fetchFromGitHub {
          owner = "emersion";
          repo = "xdg-desktop-portal-wlr";
          rev = "v0.8.4";
          hash = "sha256-8Ohgkz13FcG8ddjjgreXkvFD2Q+zUDZnAM4Oh+C9P/s=";
        };
      });
    })
  ];

  networking.networkmanager.enable = true;

  networking.firewall.trustedInterfaces = [ "enp5s0" ];

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
      faugus.enable = true;
      dolphin-emu.enable = true;
      wayfire.enable = true;
      pcsx.enable = true;
      waybar.enable = true;
      fuzzel.enable = true;
      hyprland.enable = true;
    };
  };
}
