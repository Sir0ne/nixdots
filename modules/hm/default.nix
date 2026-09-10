{ ... }: {
  home.stateVersion = "26.11";
  imports = [
    ./hyprland
    ./wayfire
    ./zen-browser
    ./fuzzel
    ./kitty
    ./git
    ./nixcord
    ./stylix
    ./waybar
    ./fish
    ./nvim
    ./games/retroarch
    ./games/pcsx
    ./games/prismlauncher
    ./dl-grimoire
    ./qbz
    ./faugus
    ./dolphin-emu
  ];
}
