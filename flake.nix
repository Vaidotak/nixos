{
  description = "Flake pajungimas 2024.12.26";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      vaidotak = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./networking.nix
          ./desktop.nix
          ./users.nix
          ./software.nix
          ./hardware.nix
          ./updates.nix
          ./services.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vaidotak = import ./home.nix;
          }
        ];
      };
    };
  };
}
