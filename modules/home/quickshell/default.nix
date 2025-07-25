{
  inputs,
  lib,
  config,
  ...
}: {
  home = {
    packages = [
      inputs.quickshell.packages.x86_64-linux.default
    ];

    #file.".config/quickshell".source = ./config;

    activation.symlinkQuickshell = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sfn "${config.home.homeDirectory}/.nixos/modules/home/quickshell/config" "${config.home.homeDirectory}/.config/quickshell"
    '';
  };

  qt.enable = true;
}
