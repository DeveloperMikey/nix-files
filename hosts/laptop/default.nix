{pkgs, ...}: {
  imports = [
    ./disko-config.nix
    ../../modules/fish.nix
    ../../modules/garbage-collection.nix
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  networking.hostName = "thinker";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
  ];

  zramSwap = {enable = true;};

  programs.nix-ld.enable = true;

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "24.11"; # No changing
}
