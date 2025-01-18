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
    iw # Belaidžio tinklo įrankiai

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

  programs.firefox = {
  enable = true;
  policies = {
    Extensions = {
      Install = builtins.map (ext: "https://addons.mozilla.org/firefox/downloads/latest/${ext}/latest.xpi") [
        "keepassxc-browser" # Saugus slaptažodžių valdymas. Integracija su KeepassXC slaptažodžių tvarkykle, leidžia automatiškai užpildyti prisijungimo formas.
        "darkreader" # Tamsus režimas visoms svetainėms. Sumažina akių nuovargį tamsiu paros metu, pritaikydamas tamsią temą svetainėms, kurios jos neturi.
        "privacy-badger" # Privatumo apsauga. Automatiškai blokuoja sekimo priemones ir reklaminius skelbimus, kurie seka jūsų veiklą internete.
        "libredirect" # Nukreipia iš sekimo nuorodų. Apsaugo nuo sekimo per nuorodas, kurios nukreipia per sekimo serverius.
        "tree-style-tab" # Skirtukų tvarkymas medžio stiliumi. Leidžia tvarkyti atidarytus skirtukus vertikaliame medyje, pagerinant naršymo patogumą ir organizavimą.
        "ublock-origin" # Efektyvus reklamų ir sekimo priemonių blokatorius. Blokuoja reklamas, sekimo priemones ir kenkėjiškas programas, pagerindamas naršymo greitį ir privatumą.
        "https-everywhere" # Užtikrina saugų HTTPS ryšį. Automatiškai perjungia svetaines į saugų HTTPS protokolą, jei jis yra prieinamas, taip apsaugant jūsų duomenis.
        "cookie-autodelete" # Automatinis slapukų valymas. Ištrina slapukus pasibaigus naršymo sesijai arba uždarius skirtuką, taip padidinant privatumą.
        "https-only" # Priverstinis HTTPS režimas. Blokuoja HTTP svetaines ir priverčia naudoti tik HTTPS, taip užtikrinant saugesnį naršymą.
        "absolute-enable-right-click" # Atblokuoja dešinio pelės klavišo meniu. Leidžia naudoti dešinį pelės klavišą svetainėse, kurios jį blokuoja.
        "deepl-translate" # Vertimas naudojant DeepL. Leidžia greitai versti tekstą svetainėse naudojant DeepL vertimo paslaugą.
        "clearcache" # Greitas talpyklos valymas. Leidžia greitai išvalyti naršyklės talpyklą, slapukus ir kitus laikinus failus.
        "easyscreenshot" # Ekrano nuotraukų darymas. Leidžia lengvai daryti ekrano nuotraukas ir jas redaguoti.
        "feedly-notifier" # Pranešimai apie naujienas iš Feedly. Rodo pranešimus apie naujus straipsnius Feedly prenumeratose.
        "i-dont-care-about-cookies" # Automatinis sutikimas su slapukų pranešimais. Automatiškai priima arba atmeta slapukų pranešimus svetainėse, taip taupant laiką.
        "gmail-notifier-restartless" # Pranešimai apie naujus laiškus Gmail. Rodo pranešimus apie naujus laiškus Gmail paskyroje.
        "web-clipper-obsidian" # Iškarpos iš interneto į Obsidian. Leidžia išsaugoti interneto puslapių iškarpas tiesiai į Obsidian užrašų programą.
        "popupoff" # Iškylančių langų blokavimas. Blokuoja nepageidaujamus iškylančius langus.
        "single-file" # Išsaugo interneto puslapį kaip vieną HTML failą. Leidžia išsaugoti visą interneto puslapį viename faile, įskaitant stilius ir vaizdus.
        "styl-us" # Vartotojo stilių valdymas. Leidžia kurti ir naudoti vartotojo stilius svetainėms, keičiant jų išvaizdą.
        "to-deepl" # Teksto siuntimas į DeepL vertimui. Leidžia greitai nusiųsti pažymėtą tekstą į DeepL vertimo svetainę.
        "to-google-translate" # Teksto siuntimas į Google Translate vertimui. Leidžia greitai nusiųsti pažymėtą tekstą į Google Translate vertimo svetainę.
        "emoji-sav" # Emoji išsaugojimas. Leidžia išsaugoti emoji vaizdus.
        "raindropio" # Nuorodų tvarkymas. Leidžia išsaugoti ir tvarkyti nuorodas į interneto puslapius.
        "read-aloud" # Teksto skaitymas balsu. Leidžia klausytis interneto puslapių teksto.
        "orbit-summarizer" # Puslapių apibendrinimas. Automatiškai apibendrina interneto puslapių turinį.
        "quick-currency-converter" # Valiutos keitimas. Leidžia greitai konvertuoti valiutas interneto puslapiuose.
      ];
    };
  };
};

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "imv";
  };
}
