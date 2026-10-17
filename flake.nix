{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    grub-themes.url = "github:jeslie0/nixos-grub-themes";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    hosts = [ "vm" ];

    mkHost = hostname: nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/${hostname}/hardware-configuration.nix
        ./common/configuration.nix
        inputs.home-manager.nixosModules.default
        {
          networking.hostName = hostname;
          home-manager.sharedModules = [
            inputs.plasma-manager.homeModules.plasma-manager
          ];
        }
      ];
    };
  in {
    nixosConfigurations = nixpkgs.lib.genAttrs hosts mkHost;
  };
}
