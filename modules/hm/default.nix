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
    ./games/retroarch
    ./games/pcsx
    ./faugus
    ./dolphin-emu
    ./fastfetch
    ./concord
  ];
}
