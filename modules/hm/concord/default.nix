{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.concord;
in
{
  options.modules.concord = {
    enable = mkEnableOption "concord";
  };

  config = mkIf cfg.enable {
    home.package = [ pkgs.concord-tui ];
    
    xdg.desktopEntries = {
      concord = {
        categories = [
	  "InstantMessaging"
	  "Chat"
	];
	exec = "${pkgs.concord}/bin/concord";
	genericName = "Chat App";
	name = "Concord";
	terminal = true;
      };
    };
  };
