{ lib, config, pkgs, ... }: 
with lib;
let cfg = config.modules.vesktop;
in { 
  options.modules.vesktop = 
    { enable = mkEnableOption "vesktop";  };
  config = mkIf cfg.enable {
    programs.vesktop.enable = true;
  };
}
