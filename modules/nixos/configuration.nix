# Keep configuration as bare as possible
# This is to keep unnecessary services out of servers
{ pkgs, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  programs.dconf.enable = true;
  environment.defaultPackages = [ ];
  programs.fish.enable = true;
  services = {
    xserver.desktopManager.xterm.enable = false;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

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
      timeout = 1;
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
    extraGroups = [
      "input"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "goofy" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };

    protectKernelImage = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.11";
}
