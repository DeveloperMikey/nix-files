{pkgs, ...}: {
  imports = [
    ./neovim
    ./gaming
    ./cli-utils.nix
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = {
      hyprland.default = ["hyprland" "gtk"];
    };
  };
}
