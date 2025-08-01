{pkgs, ...}: {
  imports = [
    ./bluetooth.nix
    ./fish.nix
    ./fonts.nix
    ./garbage-collection.nix
    ./power.nix
    ./networking.nix
    ./audio.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  users.defaultUserShell = pkgs.fish;
  hardware.i2c.enable = true;
}
