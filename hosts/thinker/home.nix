{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
    ../../modules/home/cli-utils.nix
    ../../modules/home/hyprland.nix
    ../../modules/home/firefox
    ../../modules/home/theme.nix
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
  ];

  home.stateVersion = "25.05"; # No changing
  programs.home-manager.enable = true;
}
