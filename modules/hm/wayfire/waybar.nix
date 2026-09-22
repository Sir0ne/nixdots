{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.waybar.settings = [
    {
      layer = "top";
      position = "top";
      height = 32;

      modules-left = [
        "custom/launcher"
        "wayfire/workspaces"
        "wayfire/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "network"
        "pulseaudio"
        "battery"
        "custom/power"
      ];

      "custom/launcher" = {
        format = "  ";
        on-click = " fuzzel";
        tooltip = false;
      };

      "wayfire/workspaces" = {
        on-click = "activate";
        format = "{name}";
      };

      "wayfire/window" = {
        format = "{}";
        max-length = 40;
      };

      "clock" = {
        format = "{:%H:%M - %a, %b %d}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "network" = {
        format-wifi = "  {essid}";
        format-ethernet = "🖧  min";
        format-disconnected = "⚠ Disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
      };

      "pulseaudio" = {
        format = " {icon}  {volume}%";
        format-bluetooth = "{icon} {volume}%";
        format-muted = " Muted";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
          ];
        };
      };

      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      "custom/power" = {
        format = " ⏻ ";
        on-click = "wlogout ||wayfire-exit";
        tooltip = false;
      };

      "tray" = {
        icon-size = 16;
        spacing = 10;
      };
    }
  ];
}
