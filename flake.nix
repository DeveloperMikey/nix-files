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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:

    {
      nixosConfigurations.thinkpad_e14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules =
          [ ./nixos/thinkpad_e14.nix inputs.home-manager.nixosModules.default ];
      };
    };
}

