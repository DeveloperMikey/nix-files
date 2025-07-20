{pkgs, ...}: {
  home.packages = with pkgs; [
    ripgrep
    fd # find
    fzf
    imagemagick
    ffmpeg
    jq # json
    poppler # pdf
    btop
    eza
  ];

  programs = {
    git = {
      enable = true;
      userName = "Mihkel Mäemees";
      userEmail = "maemeesmihkel@gmail.com";
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd z"];
    };

    yazi = {
      enable = true;
    };
  };
}
