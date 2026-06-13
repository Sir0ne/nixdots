{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.git;
in
{
  options.modules.git = {
    enable = mkEnableOption "git";
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = "Sir0ne";
        user.email = "vivian@hausofwong.com";
      };
      settings = {
        init.defaultBranch = "main";
        safe = {
          directory = "/home/goofy/dotfiles";
        };
      };
    };
  };
}
