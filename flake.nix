{
  description = "Andira's Personal System Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    lib = nixpkgs.lib; 
  in {
    nixosConfigurations = {
      atelier = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./configuration.nix
	];
      };
    };
  };
}
