{
  config,
  pkgs,
  lib,
  ...
}: {
  options.my.gaming.lutris.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.my.gaming.lutris.enable {
    environment.systemPackages = [
      pkgs.lutris
    ];
  };
}
