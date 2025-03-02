{ config, pkgs, ... }:

let secrets = import /home/vaidotak/bin/secret.nix;

in {
  imports = [
    ./home-manager/modules/zsh-config.nix
    ./home-manager/modules/firefox.nix
    ./home-manager/modules/alacritty.nix
    ./home-manager/dotfiles.nix
    ./home-manager/modules/hyprland.nix
    ./home-manager/modules/waybar.nix
    #./home-manager/modules/shortcuts.nix
    #./modules/keepassxc.nix
    #./home-manager/modules/syncthing.nix
  ];

  home.username = "vaidotak";
  home.homeDirectory = "/home/vaidotak";

  nix.settings = secrets.nix.settings;

  programs.home-manager.enable = true;
  nix.package = pkgs.nix;
  home.enableNixpkgsReleaseCheck = false;
  nixpkgs.config.allowUnfree = true;

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
    espanso # Teksto išplėtimas
    calibre # Elektroninių knygų tvarkyklė
    vlc # Vaizdo ir garso grotuvas
    kdePackages.kleopatra # Sertifikatų valdymas ir kriptografija
    protonvpn-gui # VPN (grafinė sąsaja)
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

    
  ];

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = pkgs.hyprland;
  #   xwayland.enable = true;  # Leidžia paleisti X11 programas, pvz., xfce4-panel
  #   systemd.enable = true;

  #   settings = {
  #     # Monitorių nustatymai
  #     monitor = [
  #       "eDP-1,1920x1080@60,0x0,1"
  #       "HDMI-1,disable"
  #     ];

  #     # Įvesties nustatymai
  #     input = {
  #       kb_layout = "lt";
  #       follow_mouse = 1;  # Pelė seka fokusą
  #     };

  #     # Bendrieji nustatymai
  #     general = {
  #       gaps_in = 5;
  #       gaps_out = 10;
  #       border_size = 2;
  #     };

  #     # Greitieji klavišai
  #     "$mod" = "SUPER";  # Pagrindinis modifikatorius (Windows klavišas)
  #     bind = [
  #       "$mod, Q, exit"                # Išeiti iš Hyprland
  #       "$mod, T, exec, xfce4-terminal" # Atidaryti terminalą
  #       "$mod, W, killactive"          # Uždaryti aktyvų langą
  #       "$mod, F, togglefloating"      # Perjungti langą į plūduriuojantį režimą
  #       "$mod, LEFT, movefocus, l"     # Perkelti fokusą į kairę
  #       "$mod, RIGHT, movefocus, r"    # Perkelti fokusą į dešinę
  #       "$mod, UP, movefocus, u"       # Perkelti fokusą aukštyn
  #       "$mod, DOWN, movefocus, d"     # Perkelti fokusą žemyn
  #     ];

  #     # Paleidžiamos programos
  #     exec-once = [
  #       "nm-applet"          # Tinklo valdymas
  #       "pavucontrol"        # Garso valdymas
  #       "blueman-applet"     # Bluetooth valdymas
  #       "clipman"            # Iškarpinės valdymas
  #       "dunst"              # Pranešimų sistema
  #       "waybar"             # Lengva Wayland juosta (vietoj xfce4-panel)
  #     ];
  #   };
  # };


  home.stateVersion = "24.11";
}
