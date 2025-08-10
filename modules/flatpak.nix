{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services.flatpak.enable = true;
  environment.systemPackages = [pkgs.gnome-software];
}
