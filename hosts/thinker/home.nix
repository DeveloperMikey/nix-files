{pkgs, ...}: {
  imports = [
    ../../modules/home
    ../../modules/home/cli-utils.nix
    ../../modules/home/firefox
    ../../modules/home/theme
    ../../modules/home/kitty.nix
    ../../modules/home/hyprland.nix
    ../../modules/home/gaming.nix
    ../../modules/home/utilities.nix
    ../../modules/home/reverse-engineering.nix
  ];

  my = {
    editors.neovim.enable = true;
    gaming.minecraft.enable = true;
  };

  home = {
    username = "mike";
    homeDirectory = "/home/mike";
  };

  home.packages = with pkgs; [
    fastfetch
    vesktop
    obs-studio
    overskride
    networkmanagerapplet
    bitwarden-desktop
    sushi
    qbittorrent-enhanced
    krita
  ];

  home.stateVersion = "25.05"; # No changing
  programs.home-manager.enable = true;
}
