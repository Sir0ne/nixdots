{ pkgs, lib, config, ... }: with lib;
let cfg = config.modules.github-cli; 

in {
  options.modules.github-cli = { enable = mkEnableOption "github client";}; 
  config = mkIf cfg.enable {
    programs.gh.enable = true;
  };
}
