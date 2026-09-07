{ ... }: {
  home.stateVersion = "26.11";
  imports = [
    ./hyprland
    ./wayfire
    ./zen-browser
    ./fuzzel
    ./kitty
    ./git
    ./vesktop
    ./stylix
    ./waybar
    ./fish
    ./nvim
    ./games/retroarch
    ./games/prismlauncher
    ./dl-grimoire
    ./qbz
    ./faugus
  ];
}
