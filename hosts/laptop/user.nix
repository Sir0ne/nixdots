{ config, lib, inputs, ...  }: { 

  imports = [../../modules/default.nix ];
  config.modules = {
    zen-browser.enable = true;
    fuzzel.enable = true;
    kitty.enable = true;
    git.enable = true;
    vesktop.enable = true;
    stylix.enable = true;
    waybar.enable = true;
    hyprland.enable = true;
    retroarch.enable = true;
    github-cli.enable = true;
  };
 }
