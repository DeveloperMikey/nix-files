{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
    ../../modules/home/cli-utils.nix
    ../../modules/home/firefox
    ../../modules/home/theme.nix
    ../../modules/home/kitty.nix
    ../../modules/home/hyprland.nix
    ../../modules/home/gaming.nix
  ];

  home = {
    username = "mike";
    homeDirectory = "/home/mike";
  };

  home.packages = with pkgs; [
    fastfetch
    vesktop
    obs-studio
    kdePackages.dolphin
    overskride
    networkmanagerapplet
    bitwarden-desktop
  ];

  home.stateVersion = "25.05"; # No changing
  programs.home-manager.enable = true;
}
