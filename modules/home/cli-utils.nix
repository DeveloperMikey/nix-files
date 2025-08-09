{
  config,
  pkgs,
  ...
}: {
  my = {
    neovim.enable = true;
  };

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
    btop
    unrar
    sl
  ];

  programs = {
    git = {
      enable = true;
      userName = "Mihkel Mäemees";
      userEmail = "maemeesmihkel@gmail.com";
      extraConfig = {
        pull.rebase = false;
      };
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

    imv = {
      enable = true;
    };
    fish.enable = true;
  };
}
