{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.dolphin-emu;
in
{
  options.modules.dolphin-emu = {
    enable = mkEnableOption "dolphin emulator";
  };
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dolphin-emu
      pkgs.wheelwizard
    ];
  };
}
