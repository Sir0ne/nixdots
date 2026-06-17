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
      extraFlags = [ "--no-default-folder" ];
      settings = {
        gui.user = "goofy";
        devices = {
          "laptop" = {
            id = "laptop1";
          };
          "goofy" = {
            id = "goofy1";
          };
        };
        folders = {
          "ra-saves" = {
            path = "/home/goofy/.config/retroarch/saves";
            devices = [
              "laptop1"
              "goofy1"
            ];
          };
        };
      };
    };
  };
}
