{pkgs, ...}: {
  home.packages = with pkgs; [
    mako
    wlogout
    slurp
    grim
    adwaita-icon-theme
  ];
}
