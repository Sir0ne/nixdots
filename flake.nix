{
  description = "NixOS Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Deadlock Modmanager that i like
    grimoire.url = "github:Slush97/grimoire";

    #qobuz player cuz the package is out-of-date [temp maybe (prolly not tho lol)]
    qbz.url = "github:vicrodh/qbz";

    nixcord.url = "github:4evy/nixcord";
  };

  outputs =
    inputs@{
      home-manager,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;

      mkSystem =
        pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            { networking.hostName = hostname; }
            ./modules/nixos/configuration.nix
            ./hosts/${hostname}/user.nix

            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                backupFileExtension = "baka";

                # Sets users.goofy to have specific modules in default.nix
                # This means that I can have nixos options per user.nix
                users.goofy = import ./modules/hm/default.nix;
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
        goofy = mkSystem inputs.nixpkgs "x86_64-linux" "goofy";
        pluto = mkSystem inputs.nixpkgs "x86_64-linux" "pluto";
      };
    };
}
