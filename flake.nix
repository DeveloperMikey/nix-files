{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/dfcd5b901dbab46c9c6e80b265648481aafb01f8";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/07571773a960c1acbc25a3c7b57361b94f2d8dd5";
    home-manager.url = "github:nix-community/home-manager/2e00ed310c218127e02ffcf28ddd4e0f669fde3e";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }@inputs:

    {
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            ./hosts/wsl/default.nix
          ];
        };
      };
    };
}
