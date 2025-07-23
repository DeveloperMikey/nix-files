{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    disko = {
      url = "github:nix-community/disko/545aba02960caa78a31bd9a8709a0ad4b6320a5c";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:quickshell-mirror/quickshell/db77c71c216530159c2dcf5b269ebb4706b2e2dd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf/fe874acd37f55dd5043a06fd2284300133782cfa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nixos-wsl,
    home-manager,
    nvf,
    quickshell,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mike = ./hosts/wsl/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
            };
          }
          ./hosts/wsl/default.nix
        ];
      };
      thinker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mike = ./hosts/thinker/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
            };
          }
          ./hosts/thinker/default.nix
        ];
      };
    };
  };
}
