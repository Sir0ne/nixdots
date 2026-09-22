{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.stylix;
in
{
  options.modules.stylix = {
    enable = mkEnableOption "stylix";
  };
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
    };
  };
}
