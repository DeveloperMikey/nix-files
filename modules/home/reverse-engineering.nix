{pkgs, ...}: {
  home.packages = with pkgs; [
    cutter
    rizin
  ];
}
