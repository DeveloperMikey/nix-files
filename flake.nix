{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    ags.url = "github:Aylur/ags";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { self, nixpkgs, home-manager, rust-overlay, nixos-hardware, ... }@inputs:

    {
      nixosConfigurations.thinkpad_e14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/thinkpad_e14.nix
          inputs.home-manager.nixosModules.default
          inputs.kmonad.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [
              (pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-analyzer" ];
                targets = [ ];
              })
            ];
          })
        ];
      };
    };
}

