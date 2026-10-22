{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.concord;
in
{
  options.modules.concord = {
    enable = mkEnableOption "concord";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.concord-tui ];

    xdg.desktopEntries = {
      concord = {
        categories = [
          "InstantMessaging"
          "Chat"
        ];
        exec = "${pkgs.concord-tui}/bin/concord";
        genericName = "Chat App";
        name = "Concord";
        terminal = true;
      };
    };
  };
}
