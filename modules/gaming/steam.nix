{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  options.my.gaming.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  options.my.gaming.steam.sls = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  options.my.gaming.steam.online-fix = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.my.gaming.steam.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession = {
          enable = true;
          args = [
            "--mangoapp"
          ];
        };
        package = pkgs.steam.override {
          extraEnv =
            {
              MANGOHUD = true;
              OBS_VKCAPTURE = true;
            }
            // lib.optionalAttrs
            config.my.gaming.steam.sls {
              LD_AUDIT = "${inputs.sls-steam.packages.${pkgs.system}.sls-steam}/SLSsteam.so";
            }
            // lib.optionalAttrs config.my.gaming.steam.online-fix {
              WINEDLLOVERRIDES = "OnlineFix64=n;SteamOverlay64=n;winmm=n,b;dnet=n;steam_api64=n;winhttp=n,b";
            };
        };
      };
      gamescope = {
        enable = true;
        capSysNice = true;
        args = [
          "--mangoapp"
        ];
      };

      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      protonup
    ];
  };
}
