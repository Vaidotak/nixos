{
  config,
  pkgs,
  unstablePkgs,
  ...
}:

{
programs.alacritty = {
  enable = true;
  settings = {
    general.live_config_reload = true;

    env.TERM = "alacritty";

    window = {
      decorations = "none";
      dynamic_padding = false;
      dynamic_title = true;
      opacity = 1.0;
      startup_mode = "Maximized";
      title = "Alacritty";
      dimensions = {
        columns = 0;
        lines = 0;
      };
      padding = {
        x = 12;
        y = 12;
      };
    };

    scrolling.history = 12000;

    font = {
      builtin_box_drawing = false;
      size = 14;
      bold = {
        family = "JetBrains Mono";
        style = "Bold";
      };
      bold_italic = {
        family = "JetBrains Mono";
        style = "Bold Italic";
      };
      glyph_offset = {
        x = 0;
        y = 0;
      };
      italic = {
        family = "JetBrains Mono";
        style = "Italic";
      };
      normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };
      offset = {
        x = 0;
        y = 0;
      };
    };

    colors = {
      primary = {
        background = "#1D1F21";
        foreground = "#C5C8C6";
      };
      bright = {
        black = "#5C5C5C";
        blue = "#6699CC";
        cyan = "#5FB3B3";
        green = "#A6BC99";
        magenta = "#824F82";
        red = "#E57373";
        white = "#F3F4F5";
        yellow = "#FAC863";
      };
      cursor = {
        cursor = "CellForeground";
        text = "CellBackground";
      };
      footer_bar = {
        background = "#C0C5CE";
        foreground = "#232323";
      };
      hints = {
        end = {
          background = "CellBackground";
          foreground = "CellForeground";
        };
        start = {
          background = "CellBackground";
          foreground = "CellForeground";
        };
      };
      line_indicator = {
        background = "None";
        foreground = "None";
      };
      normal = {
        black = "#232323";
        blue = "#6699CC";
        cyan = "#5FB3B3";
        green = "#A6BC99";
        magenta = "#824F82";
        red = "#E57373";
        white = "#C0C5CE";
        yellow = "#FAC863";
      };
      search = {
        focused_match = {
          background = "CellBackground";
          foreground = "CellForeground";
        };
        matches = {
          background = "CellBackground";
          foreground = "CellForeground";
        };
      };
      selection = {
        background = "CellForeground";
        text = "CellBackground";
      };
      vi_mode_cursor = {
        cursor = "CellForeground";
        text = "CellBackground";
      };
    };

    bell = {
      animation = "EaseOutExpo";
      color = "#C0C5CE";
      command = "None";
      duration = 0;
    };

    selection = {
      save_to_clipboard = true;
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
    };

    cursor = {
      unfocused_hollow = true;
      vi_mode_style = "None";
    };

    keyboard.bindings = [
      {
        action = "Paste";
        key = "V";
        mods = "Control|Shift";
      }
      {
        action = "Copy";
        key = "C";
        mods = "Control|Shift";
      }
      {
        action = "ScrollPageUp";
        key = "PageUp";
        mods = "Shift";
      }
      {
        action = "ScrollPageDown";
        key = "PageDown";
        mods = "Shift";
      }
      {
        action = "ScrollToTop";
        key = "Home";
        mods = "Shift";
      }
      {
        action = "ScrollToBottom";
        key = "End";
        mods = "Shift";
      }
    ];

    mouse.hide_when_typing = true;

    debug = {
      highlight_damage = false;
      log_level = "Warn";
      persistent_logging = false;
      print_events = false;
      render_timer = false;
    };
  };
};
}