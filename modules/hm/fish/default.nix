{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.fish;
in
{
  options.modules.fish = {
    enable = mkEnableOption "fish";
  };
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        nrg = "doas nixos-rebuild switch --flake ~/dotfiles#goofy";
        cd-nix = "cd ~/dotfiles/";
      };
      plugins = with pkgs.fishPlugins; [
        tide
        done
      ];
    };
  };
}
