{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
    ../../modules/home/cli-utils.nix
    ../../modules/home/hyprland.nix
    ../../modules/home/firefox
    ../../modules/home/quickshell
  ];

  home = {
    username = "mike";
    homeDirectory = "/home/mike";
  };

  home.packages = with pkgs; [
    fastfetch
    vesktop
  ];

  home.stateVersion = "25.05"; # No changing
  programs.home-manager.enable = true;
}
