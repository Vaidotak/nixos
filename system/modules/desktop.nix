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
        xterm.enable = false;
      };
      
      # Klaviatūros nustatymai
      xkb = {
        layout = "lt";
        variant = "";
      };
    };
    
    # Teisingi keliai šioms opcijoms
    displayManager = {
      defaultSession = "xfce";
      autoLogin = {
        enable = false;
        user = "vaidotak";
      };
    };
    
    # Teisingas kelias Plasma 6
    desktopManager.plasma6.enable = true;
  };
  
  # Konsolės nustatymai
  console.keyMap = "lt.baltic";
  
  # Kompozitoriai
  programs.hyprland.enable = true;
  
  # Šriftų nustatymai
  fonts = {
    enableDefaultPackages = true;
    
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      font-awesome
      # Naujas būdas nurodyti Nerd Fonts
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [ "Fira Code" ];
        emoji = [ "Noto Color Emoji" ];
      };
      hinting = {
        enable = true;
        style = "full";
      };
      subpixel.rgba = "rgb";
      antialias = true;
    };
  };
}