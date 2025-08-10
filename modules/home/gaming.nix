{inputs, ...}: {
  imports = [inputs.sls-steam.homeModules.sls-steam];

  services.sls-steam.config = {
    PlayNotOwnedGames = true;
    AdditionalApps = [
      3769130
      2512930
    ];
  };

  programs.mangohud = {
    enable = true;
    settings = {
      toggle_hud = "F11";
    };
  };
}
