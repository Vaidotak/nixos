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
    kdePackages.kdialog
    zuki-themes
    # hyprland aplinka
    hyprland # Hyprland aplinka
    wl-clipboard # Wayland iškarpinės įrankis
    kitty # Terminalas
    pavucontrol # Garso valdymo grafinė sąsaja
    clipman  # Iškarpinės valdymo programa
    dunst # Pranešimų sistema
    xdg-desktop-portal-hyprland # Hyprland integracija
    xdg-desktop-portal # Portalas tarp programų ir darbalaukio
    xdg-desktop-portal-gtk # GTK integracija
    wireplumber # Pipewire valdymo programa
    wofi           # Programų meniu
    waybar         # Statuso juosta
    brightnessctl  # Šviesumo valdymas
    networkmanagerapplet # Tinklo valdymas
    git            # Versijų kontrolės sistema
    openssh          # Saugus prisijungimas
    libsForQt5.breeze-icons # Breeze ikonos
    kdePackages.breeze # Breeze ikonos
    shutter # Ekrano nuotraukų programa
    qalculate-qt # Skaičiuotuvas
    
    # LXQt # LXQt darbalaukio aplinka
    # pkgs.lxqt.lxqt-session
    # lxqt.lxqt-wayland-session
    # pkgs.lxqt.pcmanfm-qt
    # pkgs.lxqt.qterminal
    # pkgs.lxqt.lxqt-panel
    # pkgs.lxqt.lxqt-config
    # xwayland
    # lightdm-gtk-greeter

    # Kitos programos

    # rustdesk # Nuotolinio darbo programa
    # xorg.xrandr # Ekrano konfigūravimas
    # xorg.xsetroot # Fono paveikslėlio nustatymas
    # xorg.xmodmap # Būtina klaviatūros išdėstymui
    # xorg.setxkbmap # Būtina klaviatūros išdėstymui
    # chezmoi # Dotfiles valdymas

  ];

  # programs.sway.enable = true;


  # environment.etc."lightdm/sessions/lxqt-wayland.desktop".text = ''
  #   [Desktop Entry]
  #   Name=LXQt Wayland
  #   Comment=LXQt Session running on Wayland
  #   Exec=/etc/profiles/per-user/vaidotak/bin/startlxqt
  #   Type=Application
  # '';

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
