{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland.nix
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
    pkgs.neovim
    pkgs.firefox
    pkgs.btop
    pkgs.alacritty
    pkgs.wofi
    pkgs.neofetch
    pkgs.eww
    pkgs.wl-clipboard
    pkgs.waybar
    pkgs.font-awesome_5
    pkgs.usbutils
    pkgs.ripgrep
    pkgs.hyprpaper
    pkgs.brightnessctl
    pkgs.wev
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.xdg-desktop-portal-hyprland
    pkgs.swaynotificationcenter
    pkgs.zoxide
    pkgs.keepassxc
    pkgs.nextcloud-client
    pkgs.xwaylandvideobridge
    pkgs.webcord-vencord
    pkgs.obs-studio
    pkgs.git
    pkgs.git-credential-manager
    pkgs.p7zip
    pkgs.lxappearance-gtk2
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of

    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/eww/eww.scss" = {
      source = ../../dotfiles/eww/eww.scss;
    };

    ".config/eww/eww.yuck" = {
      source = ../../dotfiles/eww/eww.yuck;
    };

    ".config/hypr/hyprpaper.conf" = {
      source = ../../dotfiles/hyprland/hyprpaper.conf;
    };

    ".config/hypr/hypridle.conf" = {
      source = ../../dotfiles/hyprland/hypridle.conf;
    };

    ".config/hypr/hyprlock.conf" = {
      source = ../../dotfiles/hyprland/hyprlock.conf;
    };

    ".config/wofi/" = {
      source = ../../dotfiles/wofi;
    };

    ".config/waybar" = {
      source = ../../dotfiles/waybar;
    };

    ".config/alacritty" = {
      source = ../../dotfiles/alacritty;
    };
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mike/etc/profile.d/hm-session-vars.sh
  #

  

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
