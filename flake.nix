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
      nixosConfigurations.thinkpad_e14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/thinkpad_e14.nix
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

