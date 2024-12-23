{ config, pkgs, unstablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
# Interneto naršyklės ir komunikacija
    chromium
    librewolf # Privatumo orientuota Firefox atšaka
    filezilla # FTP klientas
    ktorrent # BitTorrent klientas
    protonvpn-cli_2 # VPN (komandinė eilutė)
    protonvpn-gui # VPN (grafinė sąsaja)
    searxng # Meta-paieškos sistema
    syncthing # Failų sinchronizavimas
    telegram-desktop # Telegram klientas
    nullmailer # Pašto siuntimo programa (paprastam naudojimui)

# Failų valdymas ir archyvavimas
    krusader # Failų tvarkyklė (panaši į Total Commander)
    krename # Failų pervadinimo įrankis
    mc # Midnight Commander (konsolinė failų tvarkyklė)
    exfatprogs # exFAT failų sistemos įrankiai
    ntfs3g # NTFS failų sistemos įrankiai
    parted # Disko particionavimo įrankis
    gparted # Grafinis disko particionavimo įrankis
    cryptsetup # Disko šifravimo įrankis
    vsftpd # FTP serveris
    samba # Failų bendrinimo protokolas
    
# Programavimas ir teksto redagavimas
    neovim # Teksto redaktorius (Vim atšaka)
    vim # Teksto redaktorius
    vscode # Kodo redaktorius
    nixpkgs-fmt # Nix kodo formatavimas
    nixfmt-rfc-style # Nix kodo formatavimas (RFC stilius)
    git # Versijų kontrolės sistema

# Sistemos įrankiai ir stebėjimas
    atuin # Komandų istorijos sinchronizavimas
    bc # Skaičiuotuvas komandinėje eilutėje
    blesh # Shell pagerinimas
    clamav # Antivirusinė programa
    fastfetch # Sistemos informacijos rodymas
    gdu # Disko naudojimo analizatorius
    inotify-tools # Failų sistemos įvykių stebėjimas
    jq # JSON apdorojimo įrankis
    keepassxc # Slaptažodžių tvarkyklė
    pinentry-curses # Slaptažodžio įvedimo programa (konsolėje)
    plymouth # Paleidimo animacija
    rsync # Failų sinchronizavimas ir atsarginės kopijos
    stacer # Sistemos optimizavimo įrankis
    systemctl-tui # Systemd valdymas konsolėje
    xclip # Darbas su iškarpine
    xdotool # Automatizacijos įrankis X lange
    zoxide # Greitas naršymas po katalogus

# KDE programos
    kdePackages.kate # Teksto redaktorius
    kdePackages.kcron # Užduočių planuotojas
    kdePackages.kdenlive # Vaizdo įrašų redaktorius
    kdePackages.kleopatra # Sertifikatų valdymas ir kriptografija
    kdePackages.kdialog # Dialogų kūrimas skriptuose
    caffeine-ng # Ekrano išjungimo valdymas

# Multimedija
    calibre # Elektroninių knygų tvarkyklė
    vlc # Vaizdo ir garso grotuvas

# Darbalaukio aplinka ir personalizavimas
    rofi # Programų paleidimo meniu
    dmenu # Dinaminis meniu
    xorg.xrandr # Ekrano konfigūravimas
    xorg.xsetroot # Fono paveikslėlio nustatymas
    polybar # Būsenos juosta
    picom # Kompozitorius
    nitrogen # Fono paveikslėlių tvarkyklė
    networkmanagerapplet # Tinklo valdymas
    dunst # Pranešimų sistema

# Kitos programos
    obsidian # Žinių valdymo programa
    python3 # Python programavimo kalba
    python3Packages.pygobject3 # Python GObject integracija
    starship # Shell prompt'as
    rustdesk # Nuotolinio darbo programa
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
