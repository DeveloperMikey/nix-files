{pkgs, ...}: {
  imports = [
    ./disko-config.nix
    ../../modules/fish.nix
    ../../modules/garbage-collection.nix
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "thinker";
  networking.networkmanager.enable = true;

  users.users = {
    mike = {
      isNormalUser = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  zramSwap = {enable = true;};

  programs.nix-ld.enable = true;

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "24.11"; # No changing
}
