{ config, pkgs, systemSettings, ... }:
let

in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    plugins = [ ];
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      monitor = ",preferred,auto,1";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi --show drun";
      exec-once = [
        "waybar"
        "$terminal"
        "firefox"
        "wl-gammarelay-rs"
        "busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 5000"
      ];
      general = { # https://wiki.hypr.land/Configuring/Variables/#general
        border_size = 1;
        gaps_in = 5;
        gaps_out = 20;
        #float_gaps = 0;
        gaps_workspaces = 0;
        #col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        #col.inactive_border = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
        extend_border_grab_area = 15;
        hover_icon_on_border = true;
        allow_tearing = false; # TODO https://wiki.hypr.land/Configuring/Tearing
        resize_corner = 0; # TODO
      };

      decoration = { # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        rounding = 10;
        rounding_power = 2.0;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
          vibrancy = 0.1696;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = { # https://wiki.hypr.land/Configuring/Variables/#animations
        enabled = true;
          
      };

      input = { # https://wiki.hyprland.org/Configuring/Variables/#input
        kb_layout = systemSettings.keyboard;
        kb_options = [
          "caps:swapescape"
        ];
        numlock_by_default = false;
        follow_mouse = 1;
        sensitivity = 0;
        natural_scroll = false;
        touchpad = {
          natural_scroll = true;
        };
      };

      group = {
        # TODO
      };

      misc = {
        disable_hyprland_logo = false;
        force_default_wallpaper = -1;
      };

      binds = {

      };

      xwayland.enabled = true;

      render = {

      };

      cursor = {
        hide_on_key_press = true;
        hide_on_touch = true;
      };

      ecosystem = {

      };
      
      # See https://wiki.hyprland.org/Configuring/Keywords/
      "$mainMod" = "ALT";

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "mainMod, Q, exec, $terminal"
        "mainMod, C, killactive,"
        "mainMod, M, exit,"
        "mainMod, E, exec, $fileManager"
        "mainMod, V, togglefloating,"
        "mainMod, space, exec, $menu"
        "mainMod, P, pseudo, # dwindle"
        "mainMod, J, togglesplit, # dwindle"
        
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];


      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
    extraConfig = ''
      general {
      #    # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
           col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
           col.inactive_border = rgba(595959aa)
      }

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations {
          enabled = yes, please :)

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = easeOutQuint,0.23,1,0.32,1
          bezier = easeInOutCubic,0.65,0.05,0.36,1
          bezier = linear,0,0,1,1
          bezier = almostLinear,0.5,0.5,0.75,1.0
          bezier = quick,0.15,0,0.1,1

          animation = global, 1, 10, default
          animation = border, 1, 5.39, easeOutQuint
          animation = windows, 1, 4.79, easeOutQuint
          animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          animation = windowsOut, 1, 1.49, linear, popin 87%
          animation = fadeIn, 1, 1.73, almostLinear
          animation = fadeOut, 1, 1.46, almostLinear
          animation = fade, 1, 3.03, quick
          animation = layers, 1, 3.81, easeOutQuint
          animation = layersIn, 1, 4, easeOutQuint, fade
          animation = layersOut, 1, 1.5, linear, fade
          animation = fadeLayersIn, 1, 1.79, almostLinear
          animation = fadeLayersOut, 1, 1.39, almostLinear
          animation = workspaces, 1, 1.94, almostLinear, fade
          animation = workspacesIn, 1, 1.21, almostLinear, fade
          animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      # workspace = w[tv1], gapsout:0, gapsin:0
      # workspace = f[1], gapsout:0, gapsin:0
      # windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
      # windowrule = rounding 0, floating:0, onworkspace:w[tv1]
      # windowrule = bordersize 0, floating:0, onworkspace:f[1]
      # windowrule = rounding 0, floating:0, onworkspace:f[1]

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
      }

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master {
          new_status = master
      }



      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrule
      # windowrule = float,class:^(kitty)$,title:^(kitty)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrule = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    '';
  };
}

