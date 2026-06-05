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
          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "clock" ];
          modules-right = [ "cpu" "memory" "tray" "custom/wlogout"  ];
          
          "hyprland/workscapes" = {
	    all-outputs = true;
            persistent-workspaces = {
	      "1" = [];
	      "2" = [];
              "3" = [];
	    };
          };

          "cpu" = {
	    format = "{}%  ";
          };
        
          "memory" = {
	    format = "{}%  ";
          };
          
          "tray" = {
            spacing = 5;
            iconts = "{} ";
          };

          "custom/wlogout" = {
            on-click = "wlogout";
            format = "{}⏻  ";
          };
        };
      };
    };
    home.packages = with pkgs; [
      wlogout
    ];
  };
}
