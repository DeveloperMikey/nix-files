{
  inputs,
  pkgs,
  ...
}: {
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
        extraEnv = {
          MANGOHUD = true;
          OBS_VKCAPTURE = true;
          LD_AUDIT = "${inputs.sls-steam.packages.${pkgs.system}.sls-steam}/SLSsteam.so";
        };
      };
    };
    /*
      gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--mangoapp"
      ];
    };
    */

    gamemode.enable = true;
  };

  environment.systemPackages = [inputs.sls-steam.packages.${pkgs.system}.wrapped];
}
