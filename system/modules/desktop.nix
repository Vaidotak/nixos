{ config, pkgs, ... }:
{
  # services.desktopManager.cosmic.enable = true;

  
  # Konsolės nustatymai
  console.keyMap = "lt.baltic";
  
  # Kompozitoriai
  programs.hyprland.enable = false;
  
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