{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.suwayomi;
in {
  options.services.suwayomi = {
    enable = mkEnableOption "suwayomi";
  };
  config = mkIf cfg.enable {
    services.suwayomi-server = {
      enable = true;
      dataDir = "/var/lib/suwayomi";
      openFirewall = true;
      settings = {
        server = {
          port = 4567;
          autoDownloadNewChapters = true;
          maxSourcesInParallel = 4;
          extensionRepos = [
            "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
          ];
        };
      };
    };
  };
}
