{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.qbz;
in
{
  options.modules.qbz = {
    enable = mkEnableOption "qbz";
  };
  config = mkIf cfg.enable {
    home.packages = [
      inputs.qbz.packages.${pkgs.system}.default
    ];
  };
}
