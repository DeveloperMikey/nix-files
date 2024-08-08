{ inputs, pkgs, ... }:

{
  imports = [
    inputs.ags.homeManagerModules.default
    ./modules/hyprland.nix
    ./modules/neovim.nix
    ./modules/firefox.nix
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
    pkgs.wezterm
    pkgs.yazi
    pkgs.ffmpegthumbnailer
    pkgs.unar
    pkgs.jq
    pkgs.poppler
    pkgs.zgrviewer
    pkgs.graphviz
    pkgs.sassc
    pkgs.vscode-langservers-extracted
    pkgs.grim
    pkgs.slurp
    pkgs.hyprpicker
    pkgs.grimblast
    pkgs.libnotify
    pkgs.zed-editor
    pkgs.nix-index
    pkgs.wf-recorder
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
    package = pkgs.gruvbox-gtk-theme;
    name = "Gruvbox-Dark";
  };

  programs.obs-studio = { enable = true; };

  programs.btop = {
    enable = true;
    settings = { color_theme = "gruvbox_dark"; };
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

      tab_bar_min_tab = "1";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_title_template =
        "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };

  programs.bun = { enable = true; };

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

    functions = {
      develop = "nix develop --command fish";
      fish_prompt = ''

          if test -n "$IN_NIX_SHELL"
            set dev_env "[dev]"
          else
            set dev_env ""
          end

          set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) "$dev_env" $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
        '';
    };
  };

  programs.ags = {
    enable = true;

    configDir = ../dotfiles/ags;

    extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_USE_XINPUT2 = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
