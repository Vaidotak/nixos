{ config, pkgs, unstablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    filezilla
    syncthing
    gnupg
    calibre
    telegram-desktop
    obsidian
    fastfetch
    clamav
    kdePackages.ktorrent
    stacer
    chromium
    vscode
    kdePackages.kate
    jq
    kdialog
    xclip
    rofi
    kdePackages.kleopatra
    pinentry-curses
    rsync
    inotify-tools
    vlc
    mc
    vim
    gdu
    krusader
    starship
    git
    neovim
    plymouth
    xdotool
    atuin
    blesh
    autokey
    systemctl-tui
    keepassxc
    protonvpn-cli_2
    protonvpn-gui
    python3
    python3Packages.pygobject3
    glib
    gobject-introspection
    kdePackages.kcron
    nullmailer
    zoxide
    cryptsetup
    parted
    bc
    searxng
    ntfs3g
    exfat
    exfatprogs
    gparted
    kdePackages.ghostwriter
    kdePackages.kdenlive
  ];

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.firefox.enable = true;

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "imv";
  };
}