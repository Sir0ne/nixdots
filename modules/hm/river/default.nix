{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.kitty;
in
{
  options.modules.river = {
    enable = mkEnableOption "river";
  };
  config = mkIf cfg.enable {
    wayland.windowManager.river = {
      enable = true;
      systemd.enable = false;
      package = null;
    };

    xdg.configFile."beansprout/config.kdl".source = ./beansprout/config.kdl;
  };
}
