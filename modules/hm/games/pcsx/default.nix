{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.pcsx;
in
{
  options.modules.pcsx = {
    enable = mkEnableOption "PCSX2";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pcsx2
    ];
  };
}
