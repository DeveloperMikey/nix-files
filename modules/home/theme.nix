{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Gruvbox-Dark-Brown";
  };

  xdg.configFile."dolphinrc".source = (pkgs.formats.ini {}).generate "dolphinrc" {
    UiSettings.ColorScheme = "Gruvbox-Dark-Brown";
  };

  xdg.dataFile."Kvantum/Gruvbox-Dark-Brown".source = "${pkgs.gruvbox-kvantum}/share/Kvantum/Gruvbox-Dark-Brown";

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

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };
}
