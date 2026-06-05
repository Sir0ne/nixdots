{lib, pkgs, config, ...}: 
with lib;
let cfg=config.modules.sddm;
in  {
  options.modules.sddm = { enable = mkEnableOption "sddm"; };
  config = mkIf cfg.enable {
    services.displayManager = {
      sessionPackages = [];
      sddm = {
	enable = true;
        wayland = {
          enable = true;
        };
      }; 
    };
  };
}
