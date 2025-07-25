{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.fira-code
    ];
  };
}
