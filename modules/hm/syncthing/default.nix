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
    enable = mkEnableOption "kitty";
  };
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      extraFlags = [ "--no-default-folder" ];
      openDefaultPorts = true;
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
