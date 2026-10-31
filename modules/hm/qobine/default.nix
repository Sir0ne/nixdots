{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.qobine-tui;
in
{
  options.modules.qobine-tui = {
    enable = mkEnableOption "qobine-tui";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./qobine.nix { };
      defaultText = lib.literalExpression "pkgs.callPackage ./qobine.nix { }";
      description = "qobine tui package";
    };
  };

  config = mkIf cfg.enable {
    home.package = [ cfg.package ];
  };
}
