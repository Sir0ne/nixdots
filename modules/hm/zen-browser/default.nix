{
  lib,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.zen-browser;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  options.modules.zen-browser = {
    enable = mkEnableOption "zen browser";
  };
  config = mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      profiles = {
        "user" = {
          id = 0;
          isDefault = true;
          name = "user";
        };
      };
    };
  };
}
