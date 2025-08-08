{pkgs, ...}: {
  imports = [
    ../../modules/general/fish.nix
    ../../modules/general/garbage-collection.nix
    ../../modules/common
  ];

  wsl.enable = true;
  wsl.defaultUser = "mike";

  networking.hostName = "wsl";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld.enable = true;

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "24.11"; # No changing
}
