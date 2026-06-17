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
            id = "laptop1";
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
        };
      };
    };
  };
}
