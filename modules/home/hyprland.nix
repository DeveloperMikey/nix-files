{
  pkgs,
  inputs,
  ...
}: let
  updateMicLed = pkgs.writeShellScript "update-mic-led" ''
    micStatus=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c MUTED)
    brightnessctl -d platform::micmute set "$micStatus"
  '';

  toggleMic = pkgs.writeShellScript "toggle-mic" ''
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ${updateMicLed}
  '';
in {
  programs = {
    wofi.enable = true;
    fuzzel.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = ",highres,auto,1,bitdepth,10";
      exec-once = [
        "${(toString inputs.shelm.packages.x86_64-linux.default)}/bin/shelm"
      ];
      bind =
        [
          "$mod, Return, exec, ${inputs.app2unit.packages.${pkgs.system}.default}/bin/app2unit ${pkgs.kitty}/bin/kitty"
          "$mod Shift, Q, killactive"
          "$mod, Tab, exec, ${pkgs.fuzzel}/bin/fuzzel" #wofi --show drun"
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

          ", print, exec, grim -g \"$(slurp)\" - | wl-copy"
          "$mod Shift, Z, exec, bash -c 'v=$(hyprctl -j getoption cursor:zoom_factor | jq \".float\" | cut -d\".\" -f1); [ \"$v\" = \"1\" ] && hyprctl -q keyword cursor:zoom_factor 3 || hyprctl -q keyword cursor:zoom_factor 1'"
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
      bindl = [
        #", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioRaiseVolume, global, shelm:raise_volume"
        #", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioLowerVolume, global, shelm:lower_volume"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${toggleMic}"
        ", XF86MonBrightnessUp, exec, brightnessctl set 3%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 3%-"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
        vrr = 1;
      };
      general = {
        gaps_in = 2;
        gaps_out = 3;
        border_size = 1;
        "col.inactive_border" = "rgb(282828)";
        #"col.active_border" = "rgb(928374)";
        "col.active_border" = "rgb(d65d0e)";
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
        repeat_delay = 200;
        touchpad = {
          disable_while_typing = false;
        };
      };
      animations.enabled = false;
      debug = {
        full_cm_proto = true;
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
          calendar = "*-*-* 21:00:00";
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

  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    slurp
    grim
    hyprpicker
    brightnessctl
    wf-recorder
    wl-clipboard
    wl-clip-persist
  ];

  xdg.portal.enable = true;
}
