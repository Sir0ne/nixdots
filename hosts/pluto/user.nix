{ inputs, ... }:
{
 
  imports = [
    ../../services/hydrodactyl
  ]; 

  environment.systemPackages = [
    inputs.compose2nix.packages.x86_64-linux.default
  ];

  virtualisation.docker = {
    enable = true;
  };

  users.users.goofy.extraGroups = [ "docker" ];

}
