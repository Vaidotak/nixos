{ config, pkgs, unstablePkgs, ... }:

let
  failuKopijosScript = pkgs.writeScriptBin "failu_kopijos.sh" ''
    #!/usr/bin/env bash
    export PATH=$HOME/.nix-profile/bin:$PATH
    # Description: Kopijuoja konfigūracinius failus į Git katalogą ir sinchronizuoja su GitHub

    GIT_BACKUP_DIR="$HOME/.config-backup"
    TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

    CONFIG_SOURCES=(
        "$HOME/.config/espanso"
        "$HOME/.config/filezilla"
        "$HOME/.config/calibre"
        "$HOME/.config/krusaderrc"
        "$HOME/.config/alacritty"
        "/home/vaidotak/.config/kitty/"
        "$HOME/.config/xfce4"
        "$HOME/.zsh_history"
        "/home/vaidotak/.config/syncthing/config.xml.v34"
        "/home/vaidotak/.config/syncthing/config.xml.bak"
        "/home/vaidotak/.config/syncthing/config.xml"
        "/home/vaidotak/.config/keepassxc/"
        "/home/vaidotak/.config/qBittorrent/"
        "/home/vaidotak/.config/autostart/"
        "/home/vaidotak/.config/mc/"
        "/home/vaidotak/.config/i3blocks/"
        "/home/vaidotak/.config/i3status/"
        "/home/vaidotak/.config/kleopatrarc"
        "/home/vaidotak/.config/geany/"
        "/home/vaidotak/myenv/generuoti_grafikus.py"
    )

    print_error() {
        echo -e "\e[31mKlaida: $1\e[0m"
    }

    print_success() {
        echo -e "\e[32m$1\e[0m"
    }

    copy_configs() {
        if [ ! -d "$GIT_BACKUP_DIR" ]; then
            mkdir -p "$GIT_BACKUP_DIR"
            print_success "Sukurtas katalogas: $GIT_BACKUP_DIR"
        fi

        for source in "''${CONFIG_SOURCES[@]}"; do
            if [ -e "$source" ]; then
                relative_path="''${source#$HOME/}"
                target_dir="$GIT_BACKUP_DIR/$(dirname "$relative_path")"
                mkdir -p "$target_dir"
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

    sync_to_github() {
        cd "$GIT_BACKUP_DIR" || {
            print_error "Nepavyko pakeisti katalogo į $GIT_BACKUP_DIR"
            exit 1
        }

        if [ ! -d ".git" ]; then
            git init
            git remote add origin "git@github.com:Vaidotak/config-backup.git"
            print_success "Inicializuota Git repozitorija"
        fi

        git add .
        git commit -m "Backup at $TIMESTAMP"
        if [ $? -eq 0 ]; then
            print_success "Sukurtas komitas: Backup at $TIMESTAMP"
        else
            print_error "Nepavyko sukurti komito"
            exit 1
        fi

        git push origin main
        if [ $? -eq 0 ]; then
            print_success "Sėkmingai nusiųsta į GitHub"
        else
            print_error "Nepavyko nusiųsti į GitHub"
        fi
    }

    copy_configs
    sync_to_github
  '';
in
{
  home.packages = with pkgs; [ git openssh failuKopijosScript ];

  # Aktyvavimo skriptas
  home.activation.backupScript = config.lib.dag.entryAfter ["writeBoundary"] ''
    echo "Vykdomas failu_kopijos.sh..."
    ${failuKopijosScript}/bin/failu_kopijos.sh
  '';
}