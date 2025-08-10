{pkgs, ...}: {
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  environment.systemPackages = [
    pkgs.nix-du
    pkgs.graphviz
  ];
}
