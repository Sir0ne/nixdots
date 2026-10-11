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
  };
}
