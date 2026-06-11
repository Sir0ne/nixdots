{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.services.navidrome;
in
{
  options.services.navidrome = {
    enable = mkEnableOption "Navidrome";
  };
  config = mkIf cfg.enable {
    services.navidrome = {
      enable = true;
      settings = {
	Port = 4533;
	Address = "127.0.0.1";
      };
      user = "navidrome";
    };
  };
}
