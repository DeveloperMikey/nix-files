{pkgs, ...}: {
  boot.loader.limine.enable = true;
  # TODO: enable when 25.11 releases
  #boot.loader.limine.secureBoot.enable = true;
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
