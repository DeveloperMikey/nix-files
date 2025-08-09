{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      background_opacity = 0.9;
    };
    font = {
      name = "Fira Code";
      package = pkgs.fira-code;
    };
    themeFile = "GruvboxMaterialDarkMedium";
  };
}
