{...}: {
  programs.kitty.enable = true;
  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = ",highres,auto,1,bitdepth,10";
      exec-once = [
        "quickshell"
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
      };
      general = {
        gaps_in = 2;
        gaps_out = 3;
        border_size = 1;
      };
    };
  };
}
