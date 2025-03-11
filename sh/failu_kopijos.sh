#!/usr/bin/env bash
export PATH=$HOME/.nix-profile/bin:$PATH
# Description: Kopijuoja konfigūracinius failus į Git katalogą ir sinchronizuoja su GitHub

# systemctl --user status failu_kopijos.service
# systemctl --user status failu_kopijos.timer

# Nustatomi kintamieji
GIT_BACKUP_DIR="$HOME/.config-backup"  # Katalogas, kuris bus sinchronizuojamas su GitHub
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)   # Datos ir laiko žyma

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
    "$HOME/.config/systemd/user/"
)

# Funkcija klaidų pranešimams
print_error() {
    echo -e "\e[31mKlaida: $1\e[0m"
}

# Funkcija sėkmės pranešimams
print_success() {
    echo -e "\e[32m$1\e[0m"
}

# Funkcija kopijuoti failus ir katalogus, išlaikant kelio struktūrą
copy_configs() {
    # Sukuriame GIT_BACKUP_DIR, jei jo nėra
    if [ ! -d "$GIT_BACKUP_DIR" ]; then
        mkdir -p "$GIT_BACKUP_DIR"
        print_success "Sukurtas katalogas: $GIT_BACKUP_DIR"
    fi

    # Kopijuojame kiekvieną šaltinį
    for source in "${CONFIG_SOURCES[@]}"; do
        if [ -e "$source" ]; then
            # Apskaičiuojame santykinį kelią nuo $HOME
            relative_path="${source#$HOME/}"
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
            print_error "Šaltinis nerastas: $source"
        fi
    done
}

# Funkcija sinchronizuoti su GitHub
sync_to_github() {
    cd "$GIT_BACKUP_DIR" || {
        print_error "Nepavyko pakeisti katalogo į $GIT_BACKUP_DIR"
        exit 1
    }

    # Inicializuojame Git repozitoriją, jei jos nėra
    if [ ! -d ".git" ]; then
        git init
        git remote add origin "git@github.com:Vaidotak/config-backup.git"
        print_success "Inicializuota Git repozitorija"
    fi

    # Pridedame visus pakeitimus
    git add .

    # Patikriname, ar yra pakeitimų
    if git diff --cached --quiet; then
        print_success "Nėra pakeitimų, nieko komitinti."
    else
        git commit -m "Backup at $TIMESTAMP"
        if [ $? -eq 0 ]; then
            print_success "Sukurtas komitas: Backup at $TIMESTAMP"
            # Siunčiame į GitHub
            git push origin main
            if [ $? -eq 0 ]; then
                print_success "Sėkmingai nusiųsta į GitHub"
            else
                print_error "Nepavyko nusiųsti į GitHub"
                exit 1
            fi
        else
            print_error "Nepavyko sukurti komito"
            exit 1
        fi
    fi
}

# Pagrindinis vykdymas
copy_configs
sync_to_github
