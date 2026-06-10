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
          modules-right = [ "custom/fcitx5" "backlight" "cpu" "memory" "tray" "custom/wlogout"  ];
          
          "custom/fcitx5" = {
	    exec = "fcitx5-remote -n";
            interval = 1;
            format = "󰌌 {}";
            tooltip = "Toggle input";
            on-click = "fcitx5-remote -t";
          };

          "hyprland/workscapes" = {
	    all-outputs = true;
            persistent-workspaces = {
	      "1" = [];
	      "2" = [];
              "3" = [];
	    };
          };
 
          "hyprland/window" = {
	    format = "{}";
            rewrite = {
	      "(.*) — Zen Browser" = "Zen Browser";
              "(.*) - fish" = "> [$1]";
              "(.*) - Discord" = "$1 - Discord";
              "(.*) \\| Vesktop" = "$1 - Discord";
              "^Discord$" = "General - Discord";
              "windowrule" = [
                {
		  name = "discord-title-format";
		  match = {
		    class = "^(discord|vesktop)$";
		  };
                  group = { new = "lock"; };
                }
	       ];
            };
            seperate-outputs = true;
          };

          "tray" = {
            spacing = 5;
            iconts = "{}";
            show-passive-items = true;
          };

          "cpu" = {
	    format = "{}%  ";
          };
        
          "memory" = {
	    format = "{}%  ";
          };

          "custom/wlogout" = {
            on-click = "wlogout";
            format = "{} ⏻  ";
          };
        };
      };
    };
    home.packages = with pkgs; [
      wlogout
    ];
  };
}
