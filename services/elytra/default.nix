{ inputs, config, pkgs, lib, ...  }: 
let
  elytra = pkgs.stdenv.mkDerivation {
    pname = "elytra";
    version = "1.4.0";
    src = pkgs.fetchurl {
      url = "https://github.com/pyrohost/elytra/releases/download/v1.4.0/elytra_linux_amd64";
      sha256 = "sha256:db9e2aadcfabd69a7ccca6b963d8c9020344473e42f5cd430a8cafe1e4f09f14";
    };

    dontUnpack = true;
    installPhase = '' 
       mkdir -p $out/bin
       cp $src $out/bin/elytra
       chmod +x $out/bin/elytra
    '';
  };
in
{

  environment.systemPackages = [ elytra ];
  
  systemd.services.elytra = {
    description = "Elytra Daemon";
    after = [ 
      "network-online.target"
      "docker.service"
    ];
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target"  ];
    requires = [ "docker.service" ];

    path = [
      pkgs.shadow
      pkgs.coreutils
      pkgs.util-linux
    ];
    
    serviceConfig = {
      ExecStart = "${elytra}/bin/elytra";
      Restart = "on-failure";
      User = "root";
      WorkingDirectory = "/var/lib/elytra";
      LimitNOFILE = 10240;
    };
  }; 
}


