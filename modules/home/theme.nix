{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "Gruvbox-Dark-Brown";
      package = pkgs.gruvbox-kvantum;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 16;
  };

  home.packages = with pkgs; [
    gruvbox-plus-icons
    kdePackages.qtsvg
    material-symbols
  ];
}
