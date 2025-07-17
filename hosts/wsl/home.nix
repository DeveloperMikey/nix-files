{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home/neovim
  ];

  home.username = "mike";
  home.homeDirectory = "/home/mike";

  programs = {
    git = {
      enable = true;
      userName = "Mihkel Mäemees";
      userEmail = "maemeesmihkel@gmail.com";
    };

    gh = {
      enable = true;
    };
  };

  home.stateVersion = "25.05"; # No changing
  programs.home-manager.enable = true;
}
