{...}: {
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
    ./fish
    ./games/retroarch
    ./games/prismlauncher
    ./nvim
  ];
}
