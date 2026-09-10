{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.modules.nixcord;
in
{
  imports = [ inputs.nixcord.homeModules.nixcord ];
  options.modules.nixcord = {
    enable = mkEnableOption "Nixcord";
  };

  config = mkIf cfg.enable {
    programs.nixcord = {
      enable = true;

      discord.enable = false;
      vesktop.enable = true;

      config = {
        plugins = {
          fakeNitro.enable = true;
        };
      };
    };
  };
}
