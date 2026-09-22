{ inputs, config, lib, ... }:
{
 
  imports = [
    ../../services/hydrodactyl
    ../../services/elytra
  ];

  # temp, move later
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
  }; 
  users.groups.cloudflared = {};

  environment.systemPackages = [
    inputs.compose2nix.packages.x86_64-linux.default
  ];

  virtualisation.docker = {
    enable = true;
  };
  
  sops.secrets."cloudflared-creds" = {
    owner = "cloudflared";
    group = "cloudflared";
  };

  services.cloudflared = {
    enable = true;
    tunnels."6c4fc55b-bc76-48de-98d8-c27dfb21c7d3" = {
      credentialsFile = config.sops.secrets."cloudflared-creds".path;
      ingress = {
        "panel.toadhog.com" = "http://localhost:80";
      };
      default = "http_status:404";
    };
  };

  systemd.services."cloudflared-tunnel-6c4fc55b-bc76-48de-98d8-c27dfb21c7d3".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "cloudflared";
    Group = "cloudflared";
  };

  users.users.goofy.extraGroups = [ "docker" ];

}
