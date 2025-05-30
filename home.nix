{ config, pkgs, ... }:

let secrets = import /home/vaidotak/bin/secret.nix;

in {
  imports = [
    ./home-manager/modules/zsh-config.nix
    ./home-manager/modules/firefox.nix
    ./home-manager/modules/brave.nix
    ./home-manager/modules/alacritty.nix
    ./home-manager/dotfiles.nix
    ./home-manager/modules/hyprland.nix
    ./home-manager/modules/waybar.nix
    #./home-manager/modules/config-files-backup.nix
    #./home-manager/modules/librewolf.nix
    #./home-manager/modules/xfce-panel.nix
    #./home-manager/modules/shortcuts.nix
    #./modules/keepassxc.nix
    #./home-manager/modules/syncthing.nix
  ];

  home.username = "vaidotak";
  home.homeDirectory = "/home/vaidotak";

  nix.settings = secrets.nix.settings;
  
  programs.home-manager.enable = true;
  nix.package = pkgs.lib.mkForce pkgs.nix;
  home.enableNixpkgsReleaseCheck = false;
  nixpkgs.config.allowUnfree = true;
  
  services.espanso = {
    enable = true;
    package = pkgs.espanso;
  };


  home.packages = with pkgs; [
    zsh # Z shell
    zsh-syntax-highlighting # Sintaksės paryškinimas
    zsh-autosuggestions # Automatiniai pasiūlymai
    python3 # Python programavimo kalba
    python3Packages.pygobject3 # Python GObject integracija
    git # Versijų kontrolės sistema
    chromium # Chromium naršyklė
    filezilla # FTP klientas
    qbittorrent # BitTorrent klientas
    obsidian # Žinių valdymo programa
    lsd # Pagerintas ls įrankis
    # espanso # Teksto išplėtimas
    calibre # Elektroninių knygų tvarkyklė
    vlc # Vaizdo ir garso grotuvas
    kdePackages.kleopatra # Sertifikatų valdymas ir kriptografija
    # protonvpn-gui # VPN (grafinė sąsaja)
    telegram-desktop # Telegram klientas
    krusader # Failų tvarkyklė (Total Commander tipo)
    mc # Midnight Commander
    vscode # Kodo redaktorius
    fastfetch # Sistemos informacijos rodymas
    gdu # Disko naudojimo analizatorius
    inotify-tools # Failų įvykių stebėjimas
    jq # JSON apdorojimo įrankis
    keepassxc # Slaptažodžių tvarkyklė
    systemctl-tui # Systemd valdymas konsolėje
    xclip # Darbas su iškarpine
    xdotool # Automatizacijos įrankis X lange
    zoxide # Greitas naršymas po katalogus
    gnumake # GNU Make įrankis
    cifs-utils # CIFS protokolo įrankiai
    tree # Katalogų medis
    iw # Belaidžio tinklo įrankiai
    udiskie # Automatinis USB įrenginių montavimas
    sops # Failų šifravimo įrankis
    age # Failų šifravimo įrankis
    yq # YAML apdorojimo įrankis
    xfce.xfce4-power-manager # XFCE energijos valdymas
    xfce.xfce4-panel # XFCE panelė
    xfce.xfce4-notifyd # XFCE pranešimų sistema
    wmctrl # Langų valdymas
    nixfmt-classic # Nix formatavimo įrankis
    featherpad # Paprastas teksto redaktorius
    geany # Paprastas kodo redaktorius
    chezmoi # Dotfiles valdymas
    brave # Brave naršyklė
    xfce.xfce4-weather-plugin # XFCE orų prognozės
    xfce.xfce4-sensors-plugin # XFCE jutiklių rodiklis
    xfce.xfce4-notes-plugin # XFCE užrašų valdymas
    copyq # Iškarpinės tvarkyklė
    feh # Paprastas paveikslėlių peržiūros įrankis
    rofi # Programų paleidimo įrankis
    kdePackages.breeze # Breeze temos reikalingos  Krusader programai
    kdePackages.breeze-icons # Breeze ikonos reikalingos  Krusader programai
    xarchiver 
    libnotify # reikalingas samba.sh skriptui
    clipnotify
    xdg-ninja 
    htop # Procesų stebėjimo įrankis

    
  ];
  
  home.stateVersion = "24.11";
}
