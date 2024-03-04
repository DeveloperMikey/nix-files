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
    pkgs.firefox
    pkgs.wofi
    pkgs.neofetch
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

  programs.obs-studio = {
    enable = true;
  };

  programs.btop = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = ''
      colorscheme gruvbox
      nmap <space> <leader>
    '';

    extraLuaConfig = ''
      ${builtins.readFile ../../dotfiles/neovim/init.lua}
      ${builtins.readFile ../../dotfiles/neovim/lsp.lua}
      ${builtins.readFile ../../dotfiles/neovim/tree.lua}
    '';

    plugins = [
      pkgs.vimPlugins.gruvbox-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.comment-nvim
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.neodev-nvim
      pkgs.vimPlugins.nvim-tree-lua

      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    extraPackages = [
      pkgs.wl-clipboard
      pkgs.nil
      pkgs.lua-language-server
    ];
  };

  programs.alacritty = {
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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
