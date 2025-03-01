{ config, pkgs, ... }:

{
  programs.waybar = {
  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      output = "eDP-1";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "battery" "pulseaudio" "network" "custom/clipboard" "custom/screenshot" "custom/logout" "custom/reboot" "custom/poweroff" ];
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
      };
      "clock" = {
        format = "{:%H:%M}";
      };
      "battery" = {
        format = "{capacity}% {icon}";
        format-icons = [ "" "" "" "" "" ];
      };
      "pulseaudio" = {
        format = "{volume}% {icon}";
      };
      "network" = {
        format-wifi = "{essid} ({signalStrength}%)";
      };
      "custom/clipboard" = {
        format = "📋";
        on-click = "cliphist list | wofi --show dmenu | cliphist decode | wl-copy";
      };
      "custom/screenshot" = {
        format = "📸";
        on-click = "grim -g \"$(slurp)\" - | wl-copy";
      };
      "custom/logout" = {
        format = "󰍃";
        on-click = "hyprctl dispatch exit";
      };
      "custom/reboot" = {
        format = "↻";
        on-click = "systemctl reboot";
      };
      "custom/poweroff" = {
        format = "⏻";
        on-click = "systemctl poweroff";
      };
    };
  };
  style = ''
    * {
      font-family: "TeX Gyre Adventor", "Fira Sans", "Font Awesome 6 Free";
      font-size: 12px;
      font-weight: bold;
    }
    window#waybar {
      background-color: rgba(43, 48, 59, 0.5);
      border-bottom: 2px solid rgba(100, 114, 125, 0.5);
      color: #ffffff;
      font-weight: bold;
    }
    #workspaces button, #clock, #battery, #pulseaudio, #network, #custom-clipboard, #custom-screenshot, #custom-logout, #custom-reboot, #custom-poweroff {
      padding: 0 10px;
      font-weight: bold;
    }
  '';
};
home.packages = with pkgs; [
  grim
  slurp
  cliphist
  wofi
  texlivePackages.tex-gyre # font
];
}
