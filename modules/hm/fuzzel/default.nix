{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fuzzel;
in {
  options.modules.fuzzel = {enable = mkEnableOption "fuzzel";};
  config = mkIf cfg.enable {
    programs.fuzzel.enable = true;
  };
}
