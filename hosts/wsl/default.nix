{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [

  ];

  wsl.enable = true;
  wsl.defaultUser = "mike";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mike = ./home.nix;

  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
    nixfmt-rfc-style
    gh
  ];

  programs.nix-ld.enable = true;

  system.stateVersion = "24.11"; # No changing
}
