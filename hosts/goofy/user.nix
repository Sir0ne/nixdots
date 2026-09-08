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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    displayManager.ly.enable = true;
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

  home-manager.users.goofy = {
    config.modules = {
      zen-browser.enable = true;
      kitty.enable = true;
      git.enable = true;
      vesktop.enable = true;
      stylix.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      fuzzel.enable = true;
      retroarch.enable = true;
      nvim.enable = true;
      prismlauncher.enable = true;
      grimoire.enable = true;
      faugus.enable = true;
      dolphin-emu.enable = true;
    };
  };
}
