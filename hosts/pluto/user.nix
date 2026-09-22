{
  services.openssh = {
    enable = true; # opens port 22 in the firewall by default
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.goofy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE1tAPpQlQRxOHE+b3hbfgvyb5s1hvqJ+By/Vq5INFDr vivian@hausofwong.com"
    ];
  };
}
