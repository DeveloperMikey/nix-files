{pkgs, ...}: {
  programs.kitty.enable = true;
  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = ",highres,auto,1,bitdepth,10";
      exec-once = [
      ];
      bind =
        [
          "$mod, Return, exec, kitty"
          "$mod Shift, Q, killactive"
          "$mod, Tab, exec, wofi --show drun"
          "$mod, V, togglefloating"
          "$mod, F, fullscreen"
          "$mod, J, togglesplit"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod Shift, left, movewindow, l"
          "$mod Shift, right, movewindow, r"
          "$mod Shift, up, movewindow, u"
          "$mod Shift, down, movewindow, d"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod Shift, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
              ]
            )
            9)
        );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };
      general = {
        gaps_in = 2;
        gaps_out = 3;
        border_size = 1;
        "col.inactive_border" = "rgb(282828)";
        "col.active_border" = "rgb(928374)";
      };
      workspace = [
        "w[t1], gapsin:0, gapsout:0, border:0"
      ];
      decoration = {
        rounding = 5;
        blur.enabled = false;
        shadow.enabled = false;
      };
      xwayland.force_zero_scaling = true;
      input = {
        kb_options = "caps:escape";
      };
    };
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [
          (toString
            ../../wallpapers/E14-Gen-4)
        ];
        wallpaper = [
          "eDP-1,${toString ../../wallpapers/E14-Gen-4}"
        ];
      };
    };

    hyprsunset = {
      enable = true;
      transitions = {
        sunrise = {
          calendar = "*-*-* 06:00:00";
          requests = [
            ["temperature" "6500"]
            ["gamma 100"]
          ];
        };
        sunset = {
          calendar = "*-*-* 19:00:00";
          requests = [
            ["temperature" "3500"]
          ];
        };
      };
    };
    hyprpolkitagent.enable = true;

    dunst = {
      enable = true;
    };
  };

  home.packages = [
    pkgs.libnotify
  ];

  xdg.portal.enable = true;
}
