{pkgs, ...}: let
  gruvbox-kvantum = "Gruvbox-Dark-Blue";
in {
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg = {
    configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = gruvbox-kvantum;
    };

    dataFile."Kvantum/${gruvbox-kvantum}".source = ./Gruvbox-Dark-Blue;
  };

  programs.bash.enable = true; # Let home manager control environment variables

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 16;
    };

    packages = with pkgs; [
      gruvbox-plus-icons
      kdePackages.qtsvg
      material-symbols
    ];
  };
}
