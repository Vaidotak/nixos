{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        lightdm = {
          enable = true;
          greeters.slick = {
            enable = true;
            theme.name = "Zukitwo-dark";
          };
        };
        sessionCommands = ''
        xrandr --output HDMI-1 --off
      '';
      };
      windowManager.i3.enable = false;
      windowManager.dwm.enable = false;
      desktopManager = {
        #plasma5.enable = true;
        xterm.enable = false;
        xfce.enable = true;
      };

      xkb = {
        layout = "lt";
        variant = "";
      };
    };
    displayManager = {
      defaultSession = "xfce";
      autoLogin = {
        enable = false;
        user = "vaidotak";
      };
    };
    desktopManager.plasma6.enable = true;
  };
  console.keyMap = "lt.baltic";
}
