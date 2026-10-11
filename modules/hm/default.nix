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
    ./nixcord
    ./waybar
    ./fish
    ./nvim
    ./games/retroarch
    ./games/pcsx
    ./games/prismlauncher
    ./faugus
    ./dolphin-emu
  ];
}
