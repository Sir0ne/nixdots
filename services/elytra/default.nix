{ inputs, config, pkgs, lib, ...  }: 
let
  elytra = pkgs.stdenv.mkDeriviation {
    pname = "elytra";
    version = "1.4.0";
    src = pkgs.fetchurl {
      url = "https://github.com/pyrohost/elytra/releases/download/v1.4.0/elytra_linux_amd64";
      sha256 = "sha256:db9e2aadcfabd69a7ccca6b963d8c9020344473e42f5cd430a8cafe1e4f09f14"
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
    description = "Elytra Daemon"
    after = [ "docker.services" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${elytra}/bin/elytra";
      Restart = "on-failure";
      LimitNOFILE = 10240;
    };
  }; 
}


