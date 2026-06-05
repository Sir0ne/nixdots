{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.waybar;
in {
  options.modules.waybar = { enable = mkEnableOption "waybar"; }; 
  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
	  layer = "top";
          position = "top";
          modules-left = [ "hyprland/workspaces" ];
           
          "hyprland/workscapes" = {
	    all-outputs = true;
            persistent-workspaces = {
	      "1" = [];
	      "2" = [];
              "3" = [];
	    };
          };
        };
      };
    };
    home.packages = with pkgs; [
      upower
    ];
  };
}
