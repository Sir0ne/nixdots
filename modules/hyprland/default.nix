{lib, pkgs, config, ...}: 
with lib;
let cfg=config.modules.hyprland;
in  {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      extraConfig = ''
        ${builtins.readFile ./hyprland.lua}
      '';
      systemd.variables = ["--all"]; 
    };
    home.packages = with pkgs; [
      mako
      libnotify
    ];
  };
}
