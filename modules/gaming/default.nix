{pkgs, ...}: {
  imports = [
    ./steam.nix
  ];
  /*
  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--expose-wayland"
      "--borderless"
      "--adaptive-sync"
      "--backend sdl"
    ];
  };
  */
  hardware.xone.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [gamemode];
      extraPackages32 = with pkgs; [gamemode];
    };
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
    mangohud
  ];
}
