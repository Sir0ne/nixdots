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
  imports = [
    ./kanshi.nix
  ];

  options.modules.river = {
    enable = mkEnableOption "river";
  };
  config = mkIf cfg.enable {
    xdg.configFile."beansprout/config.kdl".source = ./beansprout/config.kdl;

    services.mako = {
      enable = true;
      settings = {
        actions = true;
        anchor = "top-right";
        border-radius = 0;
        default-timeout = 0;
        font = "monospace 10";
        height = 100;
        icons = true;
        ignore-timeout = false;
        layer = "top";
        margin = 10;
        markup = true;
        width = 300;
      };
    };
  };
}
