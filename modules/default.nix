{ pkgs, lib, config, ... }: { 

    home.stateVersion = "26.11";
    imports = [
      ./hyprland
      ./zen-browser
      ./fuzzel
      ./kitty
      ./git
      ./vesktop
      ./stylix
      ./waybar
      ./games/retroarch
      ./games/prismlauncher
    ];
  }
