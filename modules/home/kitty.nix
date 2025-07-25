{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    themeFile = "GruvboxMaterialDarkMedium";
    settings = {
      background_opacity = 0.9;
    };
    font = {
      name = "Fira Code";
      package = pkgs.fira-code;
    };
  };
}
