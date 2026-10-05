# Wayfire desktop environment for NixOS system
# Home manager -> modules/hm/wayfire/... + modules

{ pkgs, config, ... } 
let
  wlr = pkgs.xdg-desktop-portal-wlr;
in
{
  # NixOS Configuration
  programs.wayfire = {
    enable = true;
    xwayland.enable = true;
  };

# xdg wlr bug, 0.8.2 fixed it.
  overlays = [(
    final: prev: 
    {
      wlr = prev.wlr.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "emersion";
          repo = "xdg-desktop-portal-wlr";
          rev = "v0.8.2"
          hash = "";
        };
      });
    };
  )];
}
