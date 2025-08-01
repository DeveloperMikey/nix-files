{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.ibm-plex
      pkgs.fira-code
      pkgs.nerd-fonts.fira-code
    ];
  };
}
