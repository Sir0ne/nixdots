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
<<<<<<< HEAD
=======
      ./games/retroarch
      ./games/prismlauncher
>>>>>>> c0ba694 (add: games modules (steam, prism, retroarch))
    ];
  }
