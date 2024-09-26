{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.displayManager.sessionCommands = ''
    xrandr --output HDMI-1 --off
  '';

  boot.loader.grub.extraConfig = ''
    set gfxpayload=keep
  '';

  services.xserver = {
    xkb.layout = "lt";
    xkb.variant = "";
  };

  services.xserver.desktopManager.plasma5.enable = true;
  services.displayManager.sddm.enable = false;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono" "IBMPlexMono"];})
    inter
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Fira Code" ];
    sansSerif = [ "Inter Display" ];
    serif     = [ "Inter Display"];
  };
}