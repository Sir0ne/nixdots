{ pkgs, lib, ... }: {

 

  services = { 
    cloudflared = {
      enable = true;
      tunnels."0b528b07-cb3a-43f2-b49b-e7155fba5b9e" = {
        credentialsFile = ./credFile.json;
        default = "http_status:404" ;
      };
    };
    openssh = {
      allowSFTP = false;
      settings = lib.mkForce { 
        KbdInteractiveAuthentication =  true;
        PasswordAuthentication = false;
      }; 
    };
  };

  services.prosody = {
    enable = true;
    admins = [ "vivian@hausofwong.com" ];
    virtualHosts."chat.toadhog.com" = {
      enabled = true;
      domain = "chat.toadhog.com";
    };
    muc = [ { domain = "muc.chat.toadhog.com"; } ];
    httpFileShare = {
      domain = "upload.chat.toadhog.com";
    };
  };
}
