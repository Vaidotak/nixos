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
  programs.hyprland.enable = true;
  
  fonts = {
  enableDefaultPackages = true;
  # fonts = with pkgs; [
  #   tex-gyre-fonts  # TeX Gyre šriftai
  #   fira-code        # Fira Sans ir kiti šriftai
  #   font-awesome     # Ikonoms
  #   nerdfonts       # Jeigu naudosite Nerd Fonts
  # ];
  fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans Regular" ];
      monospace = [ "Monospace Regular" ];
    };
    hinting = {
      enable = true;
      style = "full";  # Pilnas glotninimas
    };
    antialias = true;  # Įjungia anti-aliasing
  };
};
}
