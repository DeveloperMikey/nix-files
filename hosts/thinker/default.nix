{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../modules/fish.nix
    ../../modules/garbage-collection.nix
    ../../modules/hyprland.nix
    ../../modules/greetd.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  disko.devices.disk.main.device = "/dev/nvme0n1";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "thinker";
  networking.networkmanager.enable = true;

  users.users = {
    mike = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput"];
      initialPassword = "root";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    inputs.quickshell.packages.x86_64-linux.default
  ];

  zramSwap = {enable = true;};

  programs.nix-ld.enable = true;

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "24.11"; # No changing
}
