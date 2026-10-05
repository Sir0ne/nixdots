{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.kitty;
in
{
  options.modules.kitty = {
    enable = mkEnableOption "kitty";
  };
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        window_margin_width = 15;
      };
    };

    # temp, too lazy to make new file ngl
    home.packages = with pkgs; [
      nvtopPackages.amd
    ];
  };
}
