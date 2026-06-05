{lib, pkgs, config, inputs, ...}: 
with lib;
let cfg=config.modules.stylix;
in  {
  imports = [ inputs.stylix.homeModules.stylix ];
  options.modules.stylix = { enable = mkEnableOption "stylix"; };
  config = mkIf cfg.enable {
    stylix = { 
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      image = ../../assets/backgrounds/nixos.png;
    }; 
  };
}
