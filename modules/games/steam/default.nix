{lib, config, pkgs, ...}:
with lib;
let cfg = config.modules.steam;
in {
  options.modules.steam = { enable = mkEnableOption "steam";  };
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession.enable = true;
    };
    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
    };
  };
}
