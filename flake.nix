{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    horizon-launcher = {
      url = "github:Granddave/horizon-launcher.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-world-sel-theme = {
      url = "github:Lxtharia/minegrub-world-sel-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    hosts = ["vm" "smtpad"];

    mkHost = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostname = hostname;
        };
        modules = [
          ./hosts/${hostname}/hardware-configuration.nix
          ./common/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.minegrub-world-sel-theme.nixosModules.default
          {
            networking.hostName = hostname;

            home-manager.extraSpecialArgs = {inherit hostname;};

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
