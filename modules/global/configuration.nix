{ pkgs, lib, config, ... }: 

{
  
  imports = [
    ../sddm
<<<<<<< HEAD
  ]; 
 
  modules.sddm.enable = true;
=======
    ../games/steam
  ]; 

  modules = {
    sddm.enable  = true;
    steam.enable = true;
  };
>>>>>>> c0ba694 (add: games modules (steam, prism, retroarch))
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };


  programs.dconf.enable = true;
  environment.defaultPackages = [];
  services.xserver.desktopManager.xterm.enable = false;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim git
  ];
  
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      openmoji-color
    ];
    fontconfig = {
      hinting.autohint = true;
      defaultFonts.emoji = [ "OpenMoji Color" ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "goofy" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = '' 
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  boot = {
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    loader = { 
      limine = {
        enable = true;
        enableEditor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = 10;
    };
  };

  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.users.goofy = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" ];
    shell = pkgs.fish;
  };

  networking = {
   wireless.iwd.enable = true;
   firewall = {
     enable = true;
     allowedTCPPorts = [ 443 80 ];
     allowedUDPPorts = [ 443 80 ];
     allowPing = false;
   };
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
         users = [ "goofy" ];
         keepEnv = true;
         persist = true;
      }];
    };

    protectKernelImage = true;
  };
<<<<<<< HEAD
=======

  nixpkgs.config.allowUnfree = true;
>>>>>>> c0ba694 (add: games modules (steam, prism, retroarch))
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  hardware.graphics.enable = true;  

  system.stateVersion = "26.11";
}
