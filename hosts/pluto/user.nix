{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./modules/nixos/disko/disk-config.nix
  ];
  users.users.goofy = {
    initialPassword = "test";
  };

  networking.wireless.iwd.enable = true;

  boot.tmp.cleanOnBoot = true;
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      file = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/log"
        "/var/lib/systemd/coredump"
        "/tmp"
        {
          directory = "/etc/ssh";
          mode = "0755";
        }
        {
          directory = "/var/lib/minecraft";
          user = "minecraft";
          group = "mincraft";
          mode = "0700";
        }
      ];

      users.goofy = {
        files = [ ];
        directories = [
          {
            directory = ".ssh";
            mode = "0700";
          }
        ];
      };
    };
  };

  systemd.services.sops-nix = lib.mkIf (config.preservation.enable or false) {
    after = [ "preservation.target" ];
    requires = [ "preservation.target" ];
  };
}
