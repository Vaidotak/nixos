{ config, pkgs, ... }:

let
  # Skriptas bus sugeneruotas ir patalpintas Nix store
  backupScript = pkgs.writeShellScriptBin "failu_kopijos.sh" ''
    #!/usr/bin/env bash
    export PATH=${pkgs.git}/bin:$HOME/.nix-profile/bin:$PATH
    # Description: Kopijuoja konfigūracinius failus į Git katalogą ir sinchronizuoja su GitHub

    # Nustatomi kintamieji
    GIT_BACKUP_DIR="$HOME/.config-backup"  # Katalogas, kuris bus sinchronizuojamas su GitHub
    TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)   # Datos ir laiko žyma
    LOG_FILE="$HOME/.config-backup/backup.log"
    exec &> "$LOG_FILE"

    # Konfigūraciniai failai ir katalogai, kuriuos norime kopijuoti
    CONFIG_SOURCES=(
        "$HOME/.config/espanso"
        "$HOME/.config/filezilla"
        "$HOME/.config/calibre"
        "$HOME/.config/krusaderrc"
        "$HOME/.config/alacritty"
        "$HOME/.config/kitty/"
        "$HOME/.config/xfce4"
        "$HOME/.zsh_history"
        "$HOME/.config/syncthing/config.xml.v34"
        "$HOME/.config/syncthing/config.xml.bak"
        "$HOME/.config/syncthing/config.xml"
        "$HOME/.config/keepassxc/"
        "$HOME/.config/qBittorrent/"
        "$HOME/.config/autostart/"
        "$HOME/.config/mc/"
        "$HOME/.config/i3blocks/"
        "$HOME/.config/i3status/"
        "$HOME/.config/kleopatrarc"
        "$HOME/.config/geany/"
        "$HOME/myenv/generuoti_grafikus.py"
    )

    # Funkcija klaidų pranešimams
    print_error() {
        echo -e "\e[31mKlaida: $1\e[0m"
    }

    # Funkcija sėkmės pranešimams
    print_success() {
        echo -e "\e[32m$1\e[0m"
    }

    # Funkcija įspėjimams
    print_warning() {
        echo -e "\e[33mĮspėjimas: $1\e[0m"
    }

    # Funkcija kopijuoti failus ir katalogus, išlaikant kelio struktūrą
    copy_configs() {
        # Sukuriame GIT_BACKUP_DIR, jei jo nėra
        if [ ! -d "$GIT_BACKUP_DIR" ]; then
            mkdir -p "$GIT_BACKUP_DIR"
            print_success "Sukurtas katalogas: $GIT_BACKUP_DIR"
        fi

        # Kopijuojame kiekvieną šaltinį
        for source in "''${CONFIG_SOURCES[@]}"; do
            if [ -e "$source" ]; then
                # Apskaičiuojame santykinį kelią nuo $HOME
                relative_path="''${source#$HOME/}"
                target_dir="$GIT_BACKUP_DIR/$(dirname "$relative_path")"
                
                # Sukuriame tikslinį katalogą, jei jo nėra
                mkdir -p "$target_dir"
                
                # Kopijuojame failą arba katalogą
                cp -r "$source" "$target_dir/"
                if [ $? -eq 0 ]; then
                    print_success "Nukopijuota: $source -> $target_dir/"
                else
                    print_error "Nepavyko nukopijuoti: $source"
                fi
            else
                print_warning "Šaltinis nerastas: $source (praleidžiama)"
            fi
        done
    }

    # Funkcija sinchronizuoti su GitHub
    sync_to_github() {
        cd "$GIT_BACKUP_DIR" || {
            print_error "Nepavyko pakeisti katalogo į $GIT_BACKUP_DIR"
            return 1  # Naudojame return vietoj exit
        }

        # Tikriname ar Git įdiegtas
        if ! command -v git &> /dev/null; then
            print_error "Git nerastas! Įdiekite Git"
            return 1  # Naudojame return vietoj exit
        fi

        # Nustatome Git konfigūraciją, jei jos nėra
        if [ -z "$(git config --get user.name)" ]; then
            git config --local user.name "Backup Script"
            print_success "Nustatytas lokalus Git vardas: Backup Script"
        fi
        if [ -z "$(git config --get user.email)" ]; then
            git config --local user.email "backup@script.local"
            print_success "Nustatytas lokalus Git el. paštas: backup@script.local"
        fi

        # Inicializuojame Git repozitoriją, jei jos nėra
        if [ ! -d ".git" ]; then
            git init
            if [ $? -ne 0 ]; then
                print_error "Nepavyko inicializuoti Git repozitorijos"
                return 1  # Naudojame return vietoj exit
            fi
            git remote add origin "git@github.com:Vaidotak/config-backup.git"
            print_success "Inicializuota Git repozitorija"
        fi

        # Pridedame visus pakeitimus
        git add .
        if [ $? -ne 0 ]; then
            print_error "Nepavyko pridėti failų į Git"
            return 1  # Naudojame return vietoj exit
        fi

        # Patikriname, ar yra pakeitimų
        if git diff --cached --quiet; then
            print_success "Nėra pakeitimų, nieko komitinti."
            return 0  # Naudojame return vietoj exit
        else
            # Bandome sukurti komitą
            git commit -m "Backup at $TIMESTAMP"
            if [ $? -ne 0 ]; then
                print_error "Nepavyko sukurti komito. Detalesnė informacija:"
                GIT_TRACE=1 git commit -m "Backup at $TIMESTAMP"
                return 1  # Naudojame return vietoj exit
            else
                print_success "Sukurtas komitas: Backup at $TIMESTAMP"
                
                # Bandome nusiųsti į GitHub, bet nesibaigiame su klaida jei nepavyksta
                print_warning "Bandome nusiųsti į GitHub. Jei nepavyks, tai nesustabdys skripto."
                /usr/bin/git push -u origin main 2>/tmp/git-push-error.log
                if [ $? -ne 0 ]; then
                    print_warning "Nepavyko nusiųsti į GitHub, bet lokalus komitas sukurtas sėkmingai."
                    print_warning "Klaidos pranešimas:"
                    cat /tmp/git-push-error.log
                else
                    print_success "Sėkmingai nusiųsta į GitHub"
                fi
                
                # Grįžtame sėkmingai nepriklausomai nuo push rezultato
                return 0
            fi
        fi
    }

    # Pagrindinis vykdymas
    copy_configs
    sync_to_github
    # Visada grįžtame su sėkmės kodu
    exit 0
  '';
in
{
  # Įdedame skriptą į vartotojo PATH
  users.users.vaidotak.packages = [ backupScript pkgs.git ];

  # Sukonfigūruojame systemd vartotojo servisą
  systemd.user.services.backup = {
    description = "Backup Service";
    path = [ pkgs.git ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${backupScript}/bin/failu_kopijos.sh";
      User = "vaidotak";
      Group = "users";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent.service/socket";
    };
  };

  # Sukonfigūruojame systemd vartotojo laikmatį
  systemd.user.timers.backup = {
    description = "Backup Timer";
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}