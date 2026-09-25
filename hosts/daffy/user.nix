{ pkgs, ... }: {

 

  services = { 
    cloudflared = {
      enable = true;
      tunnels."0b528b07-cb3a-43f2-b49b-e7155fba5b9e" = {
        
      };
    };
    openssh = {
      allowSFTP = false;
      settings = { 
        KbdInteractiveAuthentication = true;
        PasswordAuthentication = false;
      }; 
    };
  };

  services.prosody = {
    enable = true;
    admins = [ "vivian@hausofwong.com" ];
    virtualHosts."chat.toadhog.com" = {
      enable = true;
      domain = "chat.toadhog.com";
    };
    muc = [ { domain = "muc.chat.toadhog.com"; } ];
    uploadHttp = {
      domain = "upload.chat.toadhog.com";
    };
  };
}
