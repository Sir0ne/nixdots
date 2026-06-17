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
      group = "users";
      user = "goofy";
      dataDir = "/home/goofy/Sync";
      configDir = "/home/goofy/.config/syncthing";
      settings = {
        gui.user = "goofy";
        devices = {
          "laptop" = {
            id = "3E35PU5-A4Z2KNI-BK7AYTQ-3YVAURJ-2CQKP7H-LO6KO2I-ACZTKFA-S3PERAD";
          };
          "goofy" = {
            id = "HTSKTFZ-2IPL5IN-6TVD54T-AFVNJO2-CU2S2VZ-MEVAL74-G6GGY2O-EL7QYQN";
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
            path = "/home/goofy/.config/retroarch/system/pcsx2/memcards";
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
