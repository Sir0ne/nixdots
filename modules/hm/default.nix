{ ... }: {
  home.stateVersion = "26.11";
  imports = [
    ./hyprland
    ./wayfire
    ./river
    ./zen-browser
    ./fuzzel
    ./kitty
    ./git
    ./waybar
    ./fish
    ./nvim
    ./fastfetch
    ./concord
    ./qobine
  ];
}
