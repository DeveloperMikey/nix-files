{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    themeFile = "GruvboxMaterialDarkMedium";
    font = {
      name = "Fira Code";
      package = pkgs.fira-code;
    };
  };
}
