{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;  # Leidžia paleisti X11 programas
    systemd.enable = true;

    settings = {
      # Monitorių nustatymai
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,disable"
      ];

      # Įvesties nustatymai
      input = {
        kb_layout = "lt";
        follow_mouse = 1;  # Pelė seka fokusą
        sensitivity = 0;   # Pelės jautrumas
      };

      # Bendrieji nustatymai
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        layout = "dwindle";
      };

      # Dekoracijos
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animacijos (galite išjungti, pakeisdami enabled = false)
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
        ];
      };

      # Dwindle išdėstymas
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Paleidžiamos programos
      exec-once = [
        "nm-applet"          # Tinklo valdymas
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%"  # Garso reguliavimas (be lango)
        "blueman-applet"     # Bluetooth valdymas
        "clipman"            # Iškarpinės valdymas
        "dunst"              # Pranešimų sistema
        "waybar"             # Statuso juosta
      ];

      # Aplinkos kintamieji
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # Greitieji klavišai
      "$mainMod" = "SUPER";  # Pagrindinis modifikatorius
      bind = [
        "$mainMod, Q, exec, kitty"              # Atidaryti terminalą (pakeista į kitty)
        "$mainMod, C, killactive"               # Uždaryti aktyvų langą
        "$mainMod, M, exit"                     # Išeiti iš Hyprland
        "$mainMod, E, exec, dolphin"            # Atidaryti failų tvarkyklę
        "$mainMod, V, togglefloating"           # Perjungti į plūduriuojantį režimą
        "$mainMod, R, exec, wofi --show drun"   # Atidaryti programų meniu
        "$mainMod, P, pseudo"                   # Pseudotiling perjungimas
        "$mainMod, J, togglesplit"              # Perjungti splitą (dwindle)

        # Fokusų perjungimas
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Darbo sričių perjungimas
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

        # Langų perkėlimas į darbo sritis
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

        # Speciali darbo sritis (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];

      # Pelės klavišai
      bindm = [
        "$mainMod, mouse:272, movewindow"  # SUPER + kairysis pelės klavišas tampo langus
        "$mainMod, mouse:273, resizewindow" # SUPER + dešinysis pelės klavišas keičia langų dydį
      ];

      # Multimedijos klavišai (garsui ir šviesumui)
      bindel = [
        " , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " , XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        " , XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
    };
  };

}