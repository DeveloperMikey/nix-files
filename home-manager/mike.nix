{ inputs, pkgs, ... }:

{
  imports = [
    inputs.ags.homeManagerModules.default
    ./modules/hyprland.nix
    ./modules/neovim.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mike";
  home.homeDirectory = "/home/mike";
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = [
    pkgs.firefox
    pkgs.wofi
    pkgs.wl-clipboard
    pkgs.waybar
    pkgs.usbutils
    pkgs.ripgrep
    pkgs.hyprpaper
    pkgs.brightnessctl
    pkgs.wev
    pkgs.xdg-desktop-portal-hyprland
    pkgs.swaynotificationcenter
    pkgs.zoxide
    pkgs.keepassxc
    pkgs.nextcloud-client
    pkgs.xwaylandvideobridge
    pkgs.webcord-vencord
    pkgs.git
    pkgs.git-credential-manager
    pkgs.lxappearance-gtk2
    pkgs.fzf
    pkgs.peazip
    pkgs.xfce.thunar
    pkgs.gnome.gnome-power-manager
    pkgs.swayidle
    pkgs.meson
    pkgs.ninja
    pkgs.swayidle
    pkgs.fd
    pkgs.nil
    pkgs.lua-language-server
    pkgs.gh
    pkgs.feh
    pkgs.icon-library
    pkgs.prismlauncher
    pkgs.ani-cli
    pkgs.fastfetch
    pkgs.nixfmt
    pkgs.mpv
    pkgs.rust-analyzer
    pkgs.wezterm
    pkgs.yazi
    pkgs.ffmpegthumbnailer
    pkgs.unar
    pkgs.jq
    pkgs.poppler
    pkgs.nix-du
    pkgs.zgrviewer
    pkgs.graphviz
    pkgs.sassc
    pkgs.vscode-langservers-extracted
    pkgs.grim
    pkgs.slurp
  ];

  home.file = {
    ".config/eww/eww.scss" = { source = ../dotfiles/eww/eww.scss; };

    ".config/eww/eww.yuck" = { source = ../dotfiles/eww/eww.yuck; };

    ".config/hypr/hyprpaper.conf" = {
      source = ../dotfiles/hyprland/hyprpaper.conf;
    };

    ".config/wofi/" = { source = ../dotfiles/wofi; };

    ".config/waybar" = { source = ../dotfiles/waybar; };

    ".config/alacritty" = { source = ../dotfiles/alacritty; };

    ".config/wezterm" = { source = ../dotfiles/wezterm; };
  };

  gtk.enable = true;
  gtk.cursorTheme = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 16;
  };
  gtk.iconTheme = {
    package = pkgs.gruvbox-dark-icons-gtk;
    name = "oomox-gruvbox-dark";
  };
  gtk.theme = {
    package = pkgs.gruvbox-dark-gtk;
    name = "gruvbox-dark";
  };
 
  programs.obs-studio = { enable = true; };

  programs.btop = { enable = true;
  settings = {
    color_theme = "gruvbox_dark";
    };
};

  programs.alacritty = { enable = true; };

  programs.wezterm = { enable = true; };

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    theme = "Gruvbox Dark";
    font = {
      package = pkgs.fira-code;
      name = "Fira Code";
      size = 8;
    };
    settings = {
      background_opacity = "0.8";
      dynamic_background_opacity = "true";
      background_blur = "1";
    };
  };

  programs.bun = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = false;
      screenshots = true;
      clock = true;
      indicator = true;
      fade-in = 0.2;
      effect-scale = 0.5;
      effect-pixelate = 10;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
set fish_greeting

alias rebuild="sudo nixos-rebuild switch --flake /home/mike/nix-files#thinkpad_e14"
zoxide init fish | source
export EDITOR=nvim
    '';
  };

  programs.ags = {
    enable = true;

    configDir = ../dotfiles/ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_USE_XINPUT2 = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
