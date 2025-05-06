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
      
      # Langų valdikliai
      windowManager = {
        i3.enable = false;
        dwm.enable = false;
      };
      
      # Darbalaukio aplinkos (XFCE)
      desktopManager = {
        xfce.enable = true;
        lxqt.enable = false;
        xterm.enable = false;
      };
      
      # Klaviatūros nustatymai
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
    
    desktopManager.plasma6.enable = false;
  };
  
}