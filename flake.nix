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
  };  

  outputs = inputs@{ home-manager, nixpkgs, stylix, ... }: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    lib = nixpkgs.lib;
    
    mkSystem = pkgs: system: hostname:
      pkgs.lib.nixosSystem {
	system = system;
	modules = [
	  { networking.hostName = hostname; }
	  ./modules/global/configuration.nix
          ( ./. + "/hosts/${hostname}/hardware-configuration.nix" )
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      useUserPackages = true;
	      useGlobalPkgs = true;
              extraSpecialArgs = { inherit inputs; };
              backupFileExtension = "baka";

              users.goofy = ( ./. + "/hosts/${hostname}/user.nix" );
	   };
		
	  }
	];
	  specialArgs = { inherit inputs; };	
      };
  in {
    nixosConfigurations = {
      laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
      goofy = mkSystem inputs.nixpkgs "x86_64-linux" "goofy";
    };
  };
}
