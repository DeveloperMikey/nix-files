{
  lib,
  config,
  ...
}: {
  options.my.gaming.roblox.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.my.gaming.roblox.enable {
    services.flatpak.packages = [
      "org.vinegarhq.Sober"
    ];
    services.flatpak.enable = true;
  };
}
