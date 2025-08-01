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
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
    mangohud
  ];
}
