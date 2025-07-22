{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/dfcd5b901dbab46c9c6e80b265648481aafb01f8";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/07571773a960c1acbc25a3c7b57361b94f2d8dd5";
    home-manager.url = "github:nix-community/home-manager/2e00ed310c218127e02ffcf28ddd4e0f669fde3e";
    nvf = {
      url = "github:notashelf/nvf/fe874acd37f55dd5043a06fd2284300133782cfa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    nvf,
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
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mike = ./hosts/laptop/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
            };
          }
          ./hosts/laptop/default.nix
        ];
      };
    };
  };
}
