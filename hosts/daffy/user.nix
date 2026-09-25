{ pkgs, ... }: {

  services.cloudflared = {
    enable = true;
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
