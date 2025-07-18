{pkgs, ...}: {
  imports = [
  ];

  wsl.enable = true;
  wsl.defaultUser = "mike";

  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    wget
    nixfmt-rfc-style
  ];

  programs.nix-ld.enable = true;

  system.stateVersion = "24.11"; # No changing
}
