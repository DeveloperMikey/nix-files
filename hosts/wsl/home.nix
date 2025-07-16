{ config, pkgs, ... }:

{
  home.username = "mike";
  home.homeDirectory = "/home/mike";

  home.stateVersion = "25.05"; # No changing

  programs.home-manager.enable = true;
}
