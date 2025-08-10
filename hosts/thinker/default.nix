{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../modules/common
    ../../modules/limine.nix
    ../../modules/general
    ../../modules/greetd.nix
    ../../modules/hyprland.nix
    ../../modules/gaming
    ../../modules/flatpak.nix
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

  my = {
    gaming = {
      steam.enable = true;
      steam.sls = true;
      steam.online-fix = true;
      roblox.enable = true;
      lutris.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  zramSwap = {enable = true;};

  system.stateVersion = "24.11"; # No changing
}
