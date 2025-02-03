#!/usr/bin/env bash

[[ $- == *i* ]] && source /run/current-system/sw/share/blesh/ble.sh --noattach
export BLE_ENABLE_MULTILINE=0

export EDITOR=code
export VISUAL=code

nohup /home/vaidotak/bin/nixconf_script.sh > /dev/null 2>&1 &

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History konfigūracija
HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="\033[0;34m[%F %T \033[0m"
shopt -s histappend
PROMPT_COMMAND='history -a; history -c; history -r'
HISTSIZE=2000
HISTFILESIZE=2000

# Langelio dydžio patikrinimas
shopt -s checkwinsize

# Įtraukti .bash_aliases, jei egzistuoja
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function git-bare-commit-and-push {
    read -p "Įveskite commit pranešimą: " message
    git-bare add .
    git-bare commit -m "$message"
    git-bare push
}

function viskas() {
  /home/vaidotak/bin/binbash.sh
  echo
# 5. Atnaujinti sistemos paketus
# echo -e "${CYAN}Atnaujiname sistemos paketus${NC}"

# Sukurti atsarginę konfigūracijos kopiją
echo -e "${CYAN}Kuriama atsarginė konfigūracijos kopija${NC}"
CONFIG_BACKUP_DIR="$HOME/nixos"
CONFIG_FILE="/etc/nixos/configuration.nix"
BACKUP_FILE="$CONFIG_BACKUP_DIR/configuration-$(date +'%Y%m%d-%H%M%S').nix"

mkdir -p "$CONFIG_BACKUP_DIR"
if sudo cp "$CONFIG_FILE" "$BACKUP_FILE"; then
    echo -e "${GREEN}Konfigūracijos atsarginė kopija sukurta: $BACKUP_FILE${NC}"
else
    echo -e "${RED}Nepavyko sukurti konfigūracijos atsarginės kopijos${NC}"
    return 5
fi

# Atnaujinti sistemą ir paketų šaltinius
# if sudo nixos-rebuild switch --upgrade; then
#     echo -e "${GREEN}Sistemos konfigūracija atnaujinta${NC}"
# else
#     echo -e "${RED}Nepavyko atnaujinti sistemos${NC}"
#     return 6
# fi

 /home/vaidotak/bin/regular.sh
    echo
 /home/vaidotak/bin/faktai.sh
    echo


# Sistemos informacija
echo -e "\n${MAGENTA}-------------------${NC}"
echo -e "${CYAN}Sistemos informacija:${NC}"
echo -e "${YELLOW}OS: $(grep '^NAME=' /etc/os-release | cut -d '"' -f 2) $(grep '^VERSION=' /etc/os-release | cut -d '"' -f 2)${NC}"
echo -e "${YELLOW}Instaliavimo data: $(stat -c %w / | cut -b 1-16)${NC}"
echo -e "${YELLOW}Sistemos amžius: $(( ($(date +%s) - $(stat -c %Y /)) / 86400 ))"
echo -e "${YELLOW}Kernel: $(uname -r)${NC}"
# echo -e "${YELLOW}Uptime: $(get_uptime)${NC}"
echo -e "${YELLOW}DE: $XDG_CURRENT_DESKTOP${NC}"
echo -e "${YELLOW}RAM: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')${NC}"
# echo -e "${YELLOW}Disk (/): $(df -h / | awk 'NR==2 {print $2, $3, $4, $5}')${NC}"
# echo -e "${YELLOW}Disk MSD: $(df -h /media/vaidotak/1f3e2462-ef6f-47a1-a3f8-9300d4bec261 | awk 'NR==2 {print $2, $3, $4, $5}')${NC}"
echo -e "${YELLOW}Baterija: $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {print $2}')${NC}"

  #  ~/bin/disko_vieta.sh
    echo
    ~/bin/kalendorius.sh
    echo
    ~/bin/progresas.sh
    echo
   # ~/bin/sftp.sh
}

# function rs(){
#   source $HOME/.bashrc
#   echo "Atnaujinta"
#   if [[ $1 == "-c" ]]; then
#     clear
#   fi
# }


# sync_audio_books() {
#     # Nustatome kintamuosius
#     AUDIOBOOKS_DIR="$HOME/Audiobooks"
#     OUTPUT_FILE="$HOME/Obsidian/notes/audio_knygos_sync_su_telefonu.md"
#
#     # Patikriname, ar katalogas ~/Audiobooks egzistuoja
#     if [ ! -d "$AUDIOBOOKS_DIR" ]; then
#         echo "Katalogas $AUDIOBOOKS_DIR neegzistuoja!"
#         return 1
#     fi
#
#     # Suskaičiuojame knygų skaičių
#     num_books=$(find "$AUDIOBOOKS_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
#
#     # Suskaičiuojame bendrą katalogo dydį gigabaitais
#     total_size_gb=$(du -sh "$AUDIOBOOKS_DIR" | cut -f1)
#
#     # Sukuriame failą ir įrašome pradinę informaciją
#     echo "Rastos $num_books knygos ($total_size_gb):" > "$OUTPUT_FILE"
#     echo "" >> "$OUTPUT_FILE"
#
#     # Gauname katalogų sąrašą su dydžiais
#     index=1
#     for dir in "$AUDIOBOOKS_DIR"/*; do
#         if [ -d "$dir" ]; then
#             dir_size=$(du -sh "$dir" | cut -f1)
#             dir_name=$(basename "$dir")
#             echo "$index. $dir_name - $dir_size" >> "$OUTPUT_FILE"
#             ((index++))
#         fi
#     done
#
#     echo "Sąrašas išsaugotas faile $OUTPUT_FILE"
# }

notes() {
  local tn="$HOME/Obsidian/notes/terminal_notes.md"
  local header_line_count=7  # Eilučių skaičius iki pirmo įrašo
  local first_line_after_header=$((header_line_count + 1))

  # Patikrinkite, ar failas jau egzistuoja
  if [ ! -f "$tn" ]; then
    # Lentelės pradžia (rašoma tik pirmą kartą)
    {
      echo "---"
      echo "tags:"
      echo "- terminalas"
      echo "- užrašai"
      echo "---"
      echo "| Data | Užrašas |"
      echo "|---|---|"
    } > "$tn"
  fi

  if [ -z "$1" ]; then
    # Jei argumentas tuščias, parodykite failo turinį
    cat "$tn"
  else
    # Gaukite dabartinę datą ir laiką
    local current_time
    current_time=$(date +"%Y-%m-%d %H:%M:%S")

    # Sukurkite naują failą su nauju įrašu po antraštėmis
    {
      head -n "$header_line_count" "$tn"
      echo "| $current_time | $* |"
      tail -n +"$first_line_after_header" "$tn"
    } > "$tn.tmp"

    # Pakeiskite originalų failą naujuoju
    mv "$tn.tmp" "$tn"
  fi
}

# if [ -z "$TMUX" ]; then
# tmux attach -t term || tmux new -s term
# fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(atuin init bash)"
[[ ! ${BLE_VERSION-} ]] || ble-attach
