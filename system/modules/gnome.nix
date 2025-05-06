{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      displayManager = {
        gdm = {
          enable = true;
          wayland = true; # Paliekame Wayland pagal nutylėjimą
        };
      };

      # Langų valdikliai (išjungiami, nes naudojate GNOME)
      windowManager = {
        i3.enable = false;
        dwm.enable = false;
      };

      # Darbalaukio aplinkos
      desktopManager = {
        gnome.enable = true;
        xfce.enable = false; # Išjungiamas XFCE
        lxqt.enable = false;
        xterm.enable = false;
      };

      # Klaviatūros nustatymai (paliekami tokie patys)
      xkb = {
        layout = "lt";
        variant = "";
      };
    };

    # Nustatoma numatytoji sesija į GNOME
    displayManager = {
      defaultSession = "gnome";
      autoLogin = {
        enable = false;
        user = "vaidotak";
      };
    };

    # Išjungiamas Plasma 6
    desktopManager.plasma6.enable = false;
  };

  # Įdiegiamos papildomos GNOME programos
  environment.systemPackages = with pkgs; [
    pkgs.gnome-tweaks
    pkgs.dconf-editor
    pkgs.adwaita-icon-theme
    pkgs.gnome-shell-extensions
    pkgs.gnome-terminal
    pkgs.wayland # Nors X serveris įjungtas, Wayland reikalingas GNOME
    pkgs.wl-clipboard
    pkgs.xwayland
  ];

  # Įgalinami reikiami servisai GNOME veikimui
  services.udev.packages = with pkgs; [ pkgs.gnome-settings-daemon ];

  # Konfigūruojami aplinkos kintamieji Wayland
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
  };
}