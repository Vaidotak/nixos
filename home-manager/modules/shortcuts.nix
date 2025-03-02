{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [


    (writeShellScriptBin "layout1" ''
      #!/usr/bin/env bash
      is_window_open() { wmctrl -l | grep -q "$1"; }
      if is_window_open "Firefox"; then
        wmctrl -r "Firefox" -b remove,maximized_vert,maximized_horz
        sleep 0.1
        wmctrl -r "Firefox" -e 0,0,0,960,1080
        wmctrl -a "Firefox"
      else
        firefox &
        sleep 1
        wmctrl -r "Firefox" -e 0,0,0,960,1080
        wmctrl -a "Firefox"
      fi
      if is_window_open "Visual Studio Code"; then
        wmctrl -r "Visual Studio Code" -b remove,maximized_vert,maximized_horz
        sleep 0.1
        wmctrl -r "Visual Studio Code" -e 0,960,0,960,1080
        wmctrl -a "Visual Studio Code"
      else
        code &
        sleep 1
        wmctrl -r "Visual Studio Code" -e 0,960,0,960,1080
        wmctrl -a "Visual Studio Code"
      fi
    '')

    (writeShellScriptBin "layout2" ''
      #!/usr/bin/env bash
      is_window_open() { wmctrl -l | grep -q "$1"; }
      if is_window_open "Firefox"; then
        wmctrl -r "Firefox" -b remove,maximized_vert,maximized_horz
        sleep 0.1
        wmctrl -r "Firefox" -e 0,0,0,1240,1080
        wmctrl -a "Firefox"
      else
        firefox &
        sleep 1
        wmctrl -r "Firefox" -e 0,0,0,1240,1080
        wmctrl -a "Firefox"
      fi
      if is_window_open "Terminal"; then
        wmctrl -r "Terminal" -b remove,maximized_vert,maximized_horz
        sleep 0.1
        wmctrl -r "Terminal" -e 0,1240,0,680,1080
        wmctrl -a "Terminal"
      else
        xfce4-terminal &
        sleep 1
        wmctrl -r "Terminal" -e 0,1240,0,680,1080
        wmctrl -a "Terminal"
      fi
    '')

    (writeShellScriptBin "layout3" ''
      #!/usr/bin/env bash
      is_window_open() { wmctrl -l | grep -q "$1"; }
      if is_window_open "Firefox"; then
        wmctrl -r "Firefox" -b remove,maximized_vert,maximized_horz
        sleep 0.1
        wmctrl -r "Firefox" -e 0,0,0,960,1080
        wmctrl -a "Firefox"
      else
        firefox &
        sleep 1
        wmctrl -r "Firefox" -e 0,0,0,960,1080
        wmctrl -a "Firefox"
      fi
      if is_window_open "Visual Studio Code"; then
        wmctrl -r "Visual Studio Code" -b remove,maximized_vert,maximized_horz
        sleep 0.1
        wmctrl -r "Visual Studio Code" -e 0,960,0,960,1080
        wmctrl -a "Visual Studio Code"
      else
        code &
        sleep 1
        wmctrl -r "Visual Studio Code" -e 0,960,0,960,1080
        wmctrl -a "Visual Studio Code"
      fi
    '')

    (writeShellScriptBin "grow_window" ''
      #!/usr/bin/env bash
      ACTIVE_ID=$(xdotool getactivewindow)
      eval $(xdotool getwindowgeometry --shell "$ACTIVE_ID")
      NEW_WIDTH=$((WIDTH + 50))
      wmctrl -i -r "$ACTIVE_ID" -e 0,$X,$Y,$NEW_WIDTH,$HEIGHT
      for WINDOW in $(wmctrl -l | awk '{print $1}'); do
        if [ "$WINDOW" != "$ACTIVE_ID" ]; then
          eval $(xdotool getwindowgeometry --shell "$WINDOW")
          if [ $((X + NEW_WIDTH)) -ge $X ] && [ $X -gt $((X + NEW_WIDTH - 50)) ]; then
            NEW_NEIGHBOR_WIDTH=$((WIDTH - 50))
            [ $NEW_NEIGHBOR_WIDTH -lt 100 ] && NEW_NEIGHBOR_WIDTH=100
            wmctrl -i -r "$WINDOW" -e 0,$((X + 50)),$Y,$NEW_NEIGHBOR_WIDTH,$HEIGHT
          fi
        fi
      done
    '')

    (writeShellScriptBin "shrink_window" ''
      #!/usr/bin/env bash
      ACTIVE_ID=$(xdotool getactivewindow)
      eval $(xdotool getwindowgeometry --shell "$ACTIVE_ID")
      NEW_WIDTH=$((WIDTH - 50))
      [ $NEW_WIDTH -lt 100 ] && NEW_WIDTH=100
      wmctrl -i -r "$ACTIVE_ID" -e 0,$X,$Y,$NEW_WIDTH,$HEIGHT
      for WINDOW in $(wmctrl -l | awk '{print $1}'); do
        if [ "$WINDOW" != "$ACTIVE_ID" ]; then
          eval $(xdotool getwindowgeometry --shell "$WINDOW")
          if [ $((X + NEW_WIDTH)) -le $X ] && [ $X -lt $((X + WIDTH)) ]; then
            NEW_NEIGHBOR_WIDTH=$((WIDTH + 50))
            wmctrl -i -r "$WINDOW" -e 0,$((X - 50)),$Y,$NEW_NEIGHBOR_WIDTH,$HEIGHT
          fi
        fi
      done
    '')
  ];

  xfconf.settings = {
    "xfce4-keyboard-shortcuts" = {
      "commands/custom/<Alt>F1" = "xfce4-popup-applicationsmenu";
      "commands/custom/<Alt>F2" = "xfce4-appfinder --collapsed";
      "commands/custom/<Alt>F2/startup-notify" = "true";
      "commands/custom/<Alt>F3" = "xfce4-appfinder";
      "commands/custom/<Alt>F3/startup-notify" = "true";
      "commands/custom/<Alt>Print" = "xfce4-screenshooter -w";
      "commands/custom/<Alt><Super>s" = "orca";
      "commands/custom/HomePage" = "exo-open --launch WebBrowser";
      "commands/custom/override" = "true";
      "commands/custom/<Primary><Alt>Delete" = "xfce4-session-logout";
      "commands/custom/<Primary><Alt>Escape" = "xkill";
      "commands/custom/<Primary><Alt>f" = "thunar";
      "commands/custom/<Primary><Alt>l" = "xflock4";
      "commands/custom/<Primary><Alt>t" = "exo-open --launch TerminalEmulator";
      "commands/custom/<Primary>Escape" = "xfdesktop --menu";
      "commands/custom/<Primary><Shift>Escape" = "xfce4-taskmanager";
      "commands/custom/<Alt><Shift>F1" = "layout1";
      "commands/custom/<Alt><Shift>F1/startup-notify" = "true";
      "commands/custom/<Alt><Shift>F2" = "layout2";
      "commands/custom/<Alt><Shift>F2/startup-notify" = "true";
      "commands/custom/<Alt><Shift>F3" = "layout3";
      "commands/custom/<Alt><Shift>F3/startup-notify" = "true";
      "commands/custom/Print" = "xfce4-screenshooter";
      "commands/custom/<Shift>Print" = "xfce4-screenshooter -r";
      "commands/custom/<Super>e" = "thunar";
      "commands/custom/<Super>p" = "xfce4-display-settings --minimal";
      "commands/custom/<Super>r" = "xfce4-appfinder -c";
      "commands/custom/<Super>r/startup-notify" = "true";
      "commands/custom/XF86Display" = "xfce4-display-settings --minimal";
      "commands/custom/XF86Mail" = "exo-open --launch MailReader";
      "commands/custom/XF86WWW" = "exo-open --launch WebBrowser";

      "xfwm4/custom/<Alt>Delete" = "del_workspace_key";
      "xfwm4/custom/<Alt>F10" = "maximize_window_key";
      "xfwm4/custom/<Alt>F11" = "fullscreen_key";
      "xfwm4/custom/<Alt>F12" = "above_key";
      "xfwm4/custom/<Alt>F4" = "close_window_key";
      "xfwm4/custom/<Alt>F6" = "stick_window_key";
      "xfwm4/custom/<Alt>F7" = "move_window_key";
      "xfwm4/custom/<Alt>F8" = "resize_window_key";
      "xfwm4/custom/<Alt>F9" = "hide_window_key";
      "xfwm4/custom/<Alt>Insert" = "add_workspace_key";
      "xfwm4/custom/<Alt>space" = "popup_menu_key";
      "xfwm4/custom/<Alt>Tab" = "cycle_windows_key";
      "xfwm4/custom/Down" = "down_key";
      "xfwm4/custom/Escape" = "cancel_key";
      "xfwm4/custom/Left" = "left_key";
      "xfwm4/custom/override" = "true";
      "xfwm4/custom/<Primary><Alt>d" = "show_desktop_key";
      "xfwm4/custom/<Primary><Alt>Down" = "down_workspace_key";
      "xfwm4/custom/<Primary><Alt>End" = "move_window_next_workspace_key";
      "xfwm4/custom/<Primary><Alt>Home" = "move_window_prev_workspace_key";
      "xfwm4/custom/<Primary><Alt>KP_1" = "move_window_workspace_1_key";
      "xfwm4/custom/<Primary><Alt>KP_2" = "move_window_workspace_2_key";
      "xfwm4/custom/<Primary><Alt>KP_3" = "move_window_workspace_3_key";
      "xfwm4/custom/<Primary><Alt>KP_4" = "move_window_workspace_4_key";
      "xfwm4/custom/<Primary><Alt>KP_5" = "move_window_workspace_5_key";
      "xfwm4/custom/<Primary><Alt>KP_6" = "move_window_workspace_6_key";
      "xfwm4/custom/<Primary><Alt>KP_7" = "move_window_workspace_7_key";
      "xfwm4/custom/<Primary><Alt>KP_8" = "move_window_workspace_8_key";
      "xfwm4/custom/<Primary><Alt>KP_9" = "move_window_workspace_9_key";
      "xfwm4/custom/<Primary><Alt>Left" = "left_workspace_key";
      "xfwm4/custom/<Primary><Alt>Right" = "right_workspace_key";
      "xfwm4/custom/<Primary><Alt>Up" = "up_workspace_key";
      "xfwm4/custom/<Primary>F1" = "workspace_1_key";
      "xfwm4/custom/<Primary>F10" = "workspace_10_key";
      "xfwm4/custom/<Primary>F11" = "workspace_11_key";
      "xfwm4/custom/<Primary>F12" = "workspace_12_key";
      "xfwm4/custom/<Primary>F2" = "workspace_2_key";
      "xfwm4/custom/<Primary>F3" = "workspace_3_key";
      "xfwm4/custom/<Primary>F4" = "workspace_4_key";
      "xfwm4/custom/<Primary>F5" = "workspace_5_key";
      "xfwm4/custom/<Primary>F6" = "workspace_6_key";
      "xfwm4/custom/<Primary>F7" = "workspace_7_key";
      "xfwm4/custom/<Primary>F8" = "workspace_8_key";
      "xfwm4/custom/<Primary>F9" = "workspace_9_key";
      "xfwm4/custom/<Primary><Shift><Alt>Left" = "move_window_left_key";
      "xfwm4/custom/<Primary><Shift><Alt>Right" = "move_window_right_key";
      "xfwm4/custom/<Primary><Shift><Alt>Up" = "move_window_up_key";
      "xfwm4/custom/Right" = "right_key";
      "xfwm4/custom/<Shift><Alt>Page_Down" = "lower_window_key";
      "xfwm4/custom/<Shift><Alt>Page_Up" = "raise_window_key";
      "xfwm4/custom/<Super>KP_Down" = "tile_down_key";
      "xfwm4/custom/<Super>KP_End" = "tile_down_left_key";
      "xfwm4/custom/<Super>KP_Home" = "tile_up_left_key";
      "xfwm4/custom/<Super>KP_Left" = "tile_left_key";
      "xfwm4/custom/<Super>KP_Next" = "tile_down_right_key";
      "xfwm4/custom/<Super>KP_Page_Up" = "tile_up_right_key";
      "xfwm4/custom/<Super>KP_Right" = "tile_right_key";
      "xfwm4/custom/<Super>KP_Up" = "tile_up_key";
      "xfwm4/custom/<Super>z" = "switch_application_key";
      "xfwm4/custom/Up" = "up_key";

      "commands/custom/<Super>t" = "xfce4-terminal";
      "commands/custom/<Alt>t" = "xfce4-terminal";
      "commands/custom/<Alt>[" = "grow_window";
      "commands/custom/<Alt>]" = "shrink_window";
    };
  };
}