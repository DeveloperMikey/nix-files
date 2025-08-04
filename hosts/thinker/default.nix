{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../modules/limine.nix
    ../../modules/general
    ../../modules/greetd.nix
    ../../modules/hyprland.nix
    ../../modules/gaming
  ];

  boot.loader.efi.canTouchEfiVariables = true;

  disko.devices.disk.main.device = "/dev/nvme0n1";

  networking.hostName = "thinker";

  users.users = {
    mike = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput"];
      initialPassword = "root";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  zramSwap = {enable = true;};

  system.stateVersion = "24.11"; # No changing
}
