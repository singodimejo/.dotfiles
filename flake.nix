{
  description = "Andira's Personal System Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wlctl = {
      url = "github:aashish-thapa/wlctl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, home-manager, wlctl }:
  let
    lib = nixpkgs.lib;
  in {
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
          home-manager.extraSpecialArgs = { inherit wlctl; };

          home-manager.users.andira = {
            imports = [
              ./homes/andira.nix
              catppuccin.homeModules.catppuccin
            ];
            catppuccin.enable = true;
            catppuccin.autoEnable = true;
          };
        }
      ];
    };

    checks.x86_64-linux.atelier = self.nixosConfigurations.atelier.config.system.build.toplevel;
  };
}
