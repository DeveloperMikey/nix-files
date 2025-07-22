{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
    ../../modules/home/cli-utils.nix
  ];

  home = {
    username = "mike";
    homeDirectory = "/home/mike";
  };

  home.packages = with pkgs; [
    fastfetch
  ];

  home.stateVersion = "25.05"; # No changing
  programs.home-manager.enable = true;
}
