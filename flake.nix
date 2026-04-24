{
  description = "Andira's Personal System Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, home-manager }: 
  let
    lib = nixpkgs.lib; 
  in {
    nixosConfigurations.nixos = lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
       ./hosts/nixos
	    ];
    };
    nixosConfigurations.atelier = lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        catppuccin.nixosModules.catppuccin
  	    ./hosts/atelier
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users.andira = {
            imports = [
              ./homes/andira.nix
              catppuccin.homeModules.catppuccin
            ];
            catppuccin.enable = true;
          };
        }
      ];
    };
  };
}
