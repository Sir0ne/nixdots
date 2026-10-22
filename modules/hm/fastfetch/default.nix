{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.fastfetch;
in
{
  options.modules.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos_small";
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          separator = "  ";
        };
        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "break"
          "player"
          "media"
        ];
      };
    };
  };
}
