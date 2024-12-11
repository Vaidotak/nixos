{ config, pkgs, ... }:

{

  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
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

  services.displayManager.sddm.enable = false;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "IBMPlexMono" ]; })
    inter
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Fira Code" ];
    sansSerif = [ "Inter Display" ];
    serif = [ "Inter Display" ];
  };
}
