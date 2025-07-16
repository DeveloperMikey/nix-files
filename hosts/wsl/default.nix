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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mike = ./home.nix;
    backupFileExtension = "backup";
  };

  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    wget
    nixfmt-rfc-style
  ];

  programs.nix-ld.enable = true;

  system.stateVersion = "24.11"; # No changing
}
