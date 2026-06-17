{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.syncthing;
in
{
  options.modules.syncthing = {
    enable = mkEnableOption "syncthing";
  };
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      settings = {
        gui.user = "goofy";
        devices = {
          "laptop" = {
            id = "DVCZN7Z-UXSPYGN-SQVDK2X-CH7W5XK-TAYBVIX-WZSB2Z5-2RWFSIH-A4L22QJ";
          };
          "goofy" = {
            id = "VBO4S6E-Y2ETXBZ-MNVBAF3-GHZ6EMG-FM7SLFD-2THGRQY-6WDSBJ3-LIALVAL";
          };
        };
        folders = {
          "ra-saves" = {
            path = "/home/goofy/.config/retroarch/saves";
            devices = [
              "laptop"
              "goofy"
            ];
          };
          "ra-memcards" = {
            path = "home/goofy/.config/retroarch/system/pcsx2/memcards";
            devices = [
              "laptop"
              "goofy"
            ];
          };
        };
      };
    };
  };
}
