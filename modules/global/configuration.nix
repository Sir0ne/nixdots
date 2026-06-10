{ pkgs, lib, config, ... }: 

{
  
  imports = [
    ../sddm
    ../games/steam
  ]; 
  modules = {
    sddm.enable  = true;
    steam.enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };


  programs.dconf.enable = true;
  environment.defaultPackages = [];
  
  services.xserver.desktopManager.xterm.enable = false;
  programs.fish.enable = true;

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    vim git papirus-icon-theme
  ];
  
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      openmoji-color
      nasin-nanpa-helvetica
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
        extraEntries = ''
	  /Windows
	    protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  time.timeZone = "Australia/Sydney";
  i18n= {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [  
       fcitx5-table-extra
       (pkgs.stdenv.mkDerivation {
          pname = "ilo-sitelen";
          version = "unstable-2023";

          src = pkgs.fetchFromGitHub {
            owner = "0x182d4454fb211940";
            repo = "ilo-sitelen";
            rev = "master";
            sha256 = "sha256-caQVPBPuZjOwbtcDhxAdmG7PHXe50OeSLkSBoCtMcrQ="; # Replace with actual hash if mismatched
      };

        nativeBuildInputs = with pkgs; [ cmake pkg-config ];
        buildInputs = with pkgs; [ fcitx5 ];

        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
        ];
    })
       fcitx5-gtk
     ];
      fcitx5.waylandFrontend = true;
    };
    defaultLocale = "en_US.UTF-8";
  };
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

  nixpkgs.config.allowUnfree = true;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  }; 

  system.stateVersion = "26.11";
}
