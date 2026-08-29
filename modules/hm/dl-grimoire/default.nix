{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.grimoire;
in
{
  options.modules.grimoire = {
    enable = mkEnableOption "kitty";
  };
  config = mkIf cfg.enable {
    home.packages = [ inputs.grimoire.packages.${pkgs.system}.default ];
  };
}
