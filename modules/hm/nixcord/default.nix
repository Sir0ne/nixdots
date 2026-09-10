{
  lib,
  config,
  inputs,
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
      discord.equicord.enable = true;
      config = {
        plugins = {
          fakeNitro.enable = true;
        };
      };
    };
  };
}
