{ config, pkgs, unstablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atuin
    autokey
    bc
    blesh
    calibre
    clamav
    chromium
    cryptsetup
    exfatprogs
    fastfetch
    filezilla
    gdu
    git
    glib
    gobject-introspection
    gnupg
    gparted
    inotify-tools
    jq
    kdePackages.kate
    kdePackages.kcron
    kdePackages.kdenlive
    kdePackages.kleopatra
    kdePackages.ktorrent
    kdePackages.kdialog
    keepassxc
    krusader
    mc
    neovim
    nixpkgs-fmt
    nullmailer
    ntfs3g
    obsidian
    parted
    pinentry-curses
    plymouth
    protonvpn-cli_2
    protonvpn-gui
    python3
    python3Packages.pygobject3
    rofi
    rsync
    #searxng
    stacer
    starship
    syncthing
    systemctl-tui
    telegram-desktop
    vim
    vlc
    vscode
    xclip
    xdotool
    zoxide
    dmenu
    xorg.xrandr
    xorg.xsetroot
    polybar
    picom
    nitrogen
    networkmanagerapplet
    dunst
  ];

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.firefox.enable = true;

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "imv";
  };
}
