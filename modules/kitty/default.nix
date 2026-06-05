<<<<<<< HEAD
{ pkgs, lib, config, ... }: with lib;
let cfg = config.modules.kitty; in {
  options.modules.kitty = { enable = mkEnableOption "kitty";}; config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
=======
{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.kitty; in
{
  options.modules.kitty = { enable = mkEnableOption "kitty";}; 
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;        
>>>>>>> c0ba694 (add: games modules (steam, prism, retroarch))
      settings = {
        window_margin_width = 15;
      };
    };
  };
}
