{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
    ../../modules/home/cli-utils.nix
    ../../modules/home/firefox
    ../../modules/home/theme.nix
    ../../modules/home/kitty.nix
    ../../modules/home/hyprland.nix
    ../../modules/home/quickshell
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
