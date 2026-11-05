{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.obs;
  obsSaveReplay = pkgs.writeShellScriptBin "obs-save-replay" ''
                if ${pkgs.obs-cmd}/bin/obs-cmd replay save; then
                  ${pkgs.libnotify}/bin/notify-send \
            		-a "OBS" \
            		-t "5000" \
            		"Saved Replay"
                else
                  ${pkgs.libnotify}/bin/notify-send \
                    --urgency=critical \
                    --app-name="OBS" \
    		-t "5000" \
                    "Could not save replay" \
                    "Check if OBS is running or the replay buffer is active"
                  exit 1
                fi
  '';

in
{
  options.modules.obs = {
    enable = mkEnableOption "OBS-Studio";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-vaapi
        wlrobs
        obs-pipewire-audio-capture
      ];
    };

    home.packages = [
      # WebSocket control
      pkgs.obs-cmd

      #	notifcations for shell scripts
      pkgs.libnotify

      #	shell scripts
      obsSaveReplay
    ];
  };

}
