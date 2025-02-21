{ config, pkgs, ... }:

{

services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      # desktopManager.gnome.enable = true;
      windowManager.i3.enable = false;
      windowManager.dwm.enable = false;
      desktopManager.xfce.enable = true;
      xkb = {
        layout = "lt";
        variant = "";
      };
      displayManager.sessionCommands = ''
        xrandr --output HDMI-1 --off
      '';
    };
  };

  # Configure console keymap
  console.keyMap = "lt.baltic";

  # services.displayManager.sddm.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "xfce";
  
}
