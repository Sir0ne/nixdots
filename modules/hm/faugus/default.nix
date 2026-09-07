{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.faugus;
in
{
  options.modules.faugus = {
    enable = mkEnableOption "faugus launcher";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      faugus-launcher
    ];
  };
}
