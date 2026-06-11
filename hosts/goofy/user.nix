{pkgs, ...}: {
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
      defaultFonts.emoji = ["OpenMoji Color"];
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

    displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };

  networking.wireless.iwd.enable = true;

  security.rtkit.enable = true;
  hardware = {
    graphics.enable = true;
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
    };
  };
}
