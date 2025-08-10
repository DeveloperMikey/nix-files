{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my.gaming.minecraft.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.my.gaming.minecraft.enable {
    home.packages = [
      pkgs.prismlauncher
    ];
  };
}
