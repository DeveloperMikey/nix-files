{pkgs, ...}: {
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
}
