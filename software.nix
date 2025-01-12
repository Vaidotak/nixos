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
    mosh # Mobilusis terminalas

# Failų valdymas ir archyvavimas
    krusader # Failų tvarkyklė (panaši į Total Commander)
    krename # Failų pervadinimo įrankis
    mc # Midnight Commander (konsolinė failų tvarkyklė)
    exfatprogs # exFAT failų sistemos įrankiai
    ntfs3g # NTFS failų sistemos įrankiai
    parted # Disko particionavimo įrankis
    gparted # Grafinis disko particionavimo įrankis
    cryptsetup # Disko šifravimo įrankis
    samba # Failų bendrinimo protokolas
    samba4Full # Samba 4 pilnas paketas
    
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
    gopass # Slaptažodžių tvarkyklė
    pass # Slaptažodžių tvarkyklė
    browserpass # Slaptažodžių tvarkyklės naršyklės plėtinys
    pass2csv # Slaptažodžių tvarkyklės eksportavimas
    passExtensions.pass-import # Slaptažodžių tvarkyklės importavimas
    gnumake # GNU Make įrankis
    cifs-utils # CIFS protokolo įrankiai
    libnotify # Pranešimų sistema
  
# KDE programos
    kdePackages.kate # Teksto redaktorius
    kdePackages.kcron # Užduočių planuotojas
    kdePackages.kdenlive # Vaizdo įrašų redaktorius
    kdePackages.kleopatra # Sertifikatų valdymas ir kriptografija
    kdePackages.kdialog # Dialogų kūrimas skriptuose
    kdePackages.kcalc # Skaičiuotuvas
    caffeine-ng # Ekrano išjungimo valdymas
    kdePackages.kdenetwork-filesharing # Failų bendrinimas

# Multimedija
    calibre # Elektroninių knygų tvarkyklė
    vlc # Vaizdo ir garso grotuvas

# Darbalaukio aplinka ir personalizavimas
    rofi # Programų paleidimo meniu
    dmenu # Dinaminis meniu
    xorg.xrandr # Ekrano konfigūravimas
    xorg.xsetroot # Fono paveikslėlio nustatymas

# Kitos programos
    obsidian # Žinių valdymo programa
    python3 # Python programavimo kalba
    python3Packages.pygobject3 # Python GObject integracija
    starship # Shell prompt'as
    # rustdesk # Nuotolinio darbo programa
];

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.browserpass.enable = true;

  programs.firefox.enable = true;

  environment.sessionVariables = {
  PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
  PASSWORD_STORE_EXTENSIONS_DIR = "${pkgs.passExtensions.pass-import}/lib/password-store/extensions";
};

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "imv";
  };
}
