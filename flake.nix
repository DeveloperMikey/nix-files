{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:Aylur/ags";

  };

  outputs = { self, nixpkgs, ... }@inputs:

    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      homeConfigurations.mike =
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit inputs;
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = { inherit inputs; };
        };
    };
}
