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
    programs.obs-studio = {
	enable = true;
	plugins = with pkgs.obs-studio-plugins; [ 
		obs-vkcapture	
		wlrobs
		obs-pipewire-audio-capture
	];
    };
  };
}
