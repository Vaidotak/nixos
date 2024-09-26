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
    qbittorrent
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