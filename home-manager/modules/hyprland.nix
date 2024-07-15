{ inputs, pkgs, ... }:

{
  options = {
    #hyprlandLayout = lib.mkOption {
    #  default = "master";
    #  description = "hyprland window layout";
    #};
  };

  config = {

    wayland.windowManager.hyprland = {
      enable = true;

      plugins = [
      ];

      settings = {
        monitor = ",highres,auto,auto,bitdepth,10";
        
        "$terminal" = "alacritty";
        "$mod" = "SUPER";
        "$menu" = "wofi -i --show";

	      xwayland = {
	        force_zero_scaling = true;
	      };

        windowrulev2 = [
	        "workspace 3 silent,class:(firefox)"
	        "workspace 4 silent,class:(WebCord)"
	        "workspace 5 silent,class:(steam)"
          "workspace 5 silent,title:(Steam)"
	        "minsize 1 1, title:^()$,class:^(steam)$"
	        "stayfocused, title:^()$,class:^(steam)$"
          "nofocus, title:^(notificationtoasts_*_desktop),class:(steam)"
        ];

        exec-once = [
          "ags"
	        "hyprpaper"
	        "hypridle"
	        "swaync"
	        "webcord"
	        "firefox"
	        "steam"
          "hyprctl setcursor 'Capitaine Cursors (Gruvbox)' 16"
          "swayidle -w before-sleep 'swaylock' timeout 600 'systemctl suspend' timeout 1800 'systemctl hibernate'"
	      ];	

        general = {
          layout = "dwindle";
	        gaps_in = 4;
          gaps_out = 6;
	        border_size = 2;

          allow_tearing = false;

	        "col.active_border" = "rgba(d65d0eee)";
	        "col.inactive_border" = "rgba(928374ee)";
	      };

	      bind = [
          "$mod, Return, exec, $terminal"
	        "SUPERSHIFT, Q, killactive"
	        "$mod, Tab, exec, $menu drun"
	        "$mod, V, togglefloating"
	        "$mod, P, pseudo"
	        "$mod, J, togglesplit"
          "$mod, F, fullscreen"
          "$mod, L, exec, swaylock"
	  
	        "$mod, left, movefocus, l"
	        "$mod, right, movefocus, r"
	        "$mod, up, movefocus, u"
	        "$mod, down, movefocus, d"

	        "$mod, 1, workspace, 1"
	        "$mod, 2, workspace, 2"
	        "$mod, 3, workspace, 3"
	        "$mod, 4, workspace, 4"
	        "$mod, 5, workspace, 5"
	        "$mod, 6, workspace, 6"
	        "$mod, 7, workspace, 7"
	        "$mod, 8, workspace, 8"
	        "$mod, 9, workspace, 9"
	        "$mod, 0, workspace, 10"

	        "$mod SHIFT, 1, movetoworkspacesilent, 0"
	        "$mod SHIFT, 2, movetoworkspacesilent, 2"
	        "$mod SHIFT, 3, movetoworkspacesilent, 3"
	        "$mod SHIFT, 4, movetoworkspacesilent, 4"
	        "$mod SHIFT, 5, movetoworkspacesilent, 5"
	        "$mod SHIFT, 6, movetoworkspacesilent, 6"
	        "$mod SHIFT, 7, movetoworkspacesilent, 7"
	        "$mod SHIFT, 8, movetoworkspacesilent, 8"
	        "$mod SHIFT, 9, movetoworkspacesilent, 9"
	        "$mod SHIFT, 0, movetoworkspacesilent, 10"

          "$mod, D, togglespecialworkspace"
          "$mod SHIFT, D, movetoworkspace, special"

	        "ALT, Tab, cyclenext"
	        "ALT, Tab, bringactivetotop"

	        "Alt Shift, Tab, cyclenext, prev"
	        "Alt Shift, Tab, bringactivetotop"

	        "SUPER SHIFT, left, movewindow, l"
	        "SUPER SHIFT, right, movewindow, r"
	        "SUPER SHIFT, up, movewindow, u"
	        "SUPER SHIFT, down, movewindow, d"

	        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86AudioMicMute, exec, amixer set Capture toggle"
	      ];

	      bindm = [
	        "$mod, mouse:272, movewindow"
	        "$mod, mouse:273, resizewindow"
	      ];

        binde = [
	        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
	        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
	      ];

        input = {
          "kb_layout" = "ee";
	        "follow_mouse" = "1";
	        mouse_refocus = false;
	        touchpad = {
            natural_scroll = true;
            disable_while_typing = false;
	        };
  	    };

	      decoration = {
          blur = {
            "enabled" = "true";
	          "size" = "3";
	          "passes" = "1";

	          "vibrancy" = "0.1696";
	        };

	        "drop_shadow" = "true";
	        "shadow_range" = "4";
	        "shadow_render_power" = "3";
	        "col.shadow" = "rgba(1a1a1aee)";
	      };

	      misc = {
          "force_default_wallpaper" = "0";
	        "disable_splash_rendering" = true;
	      };

	      animations = {
	        enabled = true;

	        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

	        animation = [
	          "windows, 1, 7, default"
	          "windowsOut, 1, 7, default"
	          "border, 1, 10, default"
	          "borderangle, 1, 8, default"
	          "fade, 1, 7, default"
	          #"workspaces, 1, 6, default"
	        ];
	      };

	      dwindle = {
	        pseudotile = true;
	        preserve_split = true;
	      };

	      master = {
	        new_is_master = true;
	      };

	      gestures = {
 	        workspace_swipe = false;
        };
      };
    };
  };
}
