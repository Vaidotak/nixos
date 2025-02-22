{ config, pkgs, unstablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    home-manager # Namų direktorijos valdymas
    searxng # Meta-paieškos sistema
    syncthing # Failų sinchronizavimas
    clamav # Antivirusinė programa
    rsync # Failų sinchronizavimas ir atsarginės kopijos
    exfatprogs # exFAT failų sistemos įrankiai
    ntfs3g # NTFS failų sistemos įrankiai
    parted # Disko particionavimo įrankis
    gparted # Grafinis disko particionavimo įrankis
    cryptsetup # Disko šifravimo įrankis
    samba # Failų bendrinimo protokolas
    samba4Full # Samba 4 pilnas paketas
    alsa-utils # ALSA garso įrankiai
    networkmanager # Tinklo valdymo programa
    xfce.xfwm4
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-screenshooter
    xfce.xfce4-taskmanager
    xfce.xfce4-terminal
    gnome-keyring
    xfce.xfce4-screenshooter
    xfce.xfce4-genmon-plugin
    xfce.thunar-volman
    gvfs
    udisks
    udiskie
    kdialog
    zuki-themes


    # Kitos programos

    # rustdesk # Nuotolinio darbo programa
    # xorg.xrandr # Ekrano konfigūravimas
    # xorg.xsetroot # Fono paveikslėlio nustatymas
    # xorg.xmodmap # Būtina klaviatūros išdėstymui
    # xorg.setxkbmap # Būtina klaviatūros išdėstymui
    # chezmoi # Dotfiles valdymas

  ];

  nixpkgs.config.allowUnfree = true;
  services.gnome.gnome-keyring.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "imv";
  };
}
