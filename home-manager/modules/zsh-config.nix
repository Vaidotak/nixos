{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    #

    initExtra = ''

                        # Aplinkos kintamieji
                        export EDITOR=code
                        export VISUAL=code
                        export BROWSER=firefox
                        export PAGER=less

                        cm() {
        chezmoi apply
        cd "$(chezmoi cd)"
        git add .
        if ! git diff-index --quiet HEAD --; then
          # Yra pokyčių
          git commit -m "Atnaujinti dotfiles"
          git push
        else
          echo "Nėra naujų pokyčių, nieko necommitinama."
        fi
      }


                        # Istorijos nustatymai
                        HISTFILE=~/.zsh_history
                        HISTSIZE=5000
                        SAVEHIST=3000
                        setopt inc_append_history
                        setopt share_history
                        setopt hist_expire_dups_first
                        setopt hist_ignore_dups
                        setopt hist_ignore_space
                        setopt hist_reduce_blanks

                        # Kiti nustatymai
                        setopt auto_cd
                        setopt correct
                        setopt interactive_comments
                        setopt long_list_jobs
                        setopt no_beep
                        setopt check_jobs
                        setopt no_bg_nice

                        # Completion nustatymai
                        zstyle ':completion:*' menu select

                        # aliases
                        alias ll='ls -lh'
                        alias n=fastfetch
                        alias baterija='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
                        alias wifi='nmcli -f SSID,BSSID,SIGNAL,RATE,BARS,SECURITY dev wifi list'
                        alias c='clear'
                        alias binbash='if test -f /home/vaidotak/bin/binbash.sh; then bash /home/vaidotak/bin/binbash.sh; else echo "Scenarijaus failas nerastas"; fi'
                        alias install='stat -c %w / | cut -b 1-16'
                        alias zurnalas='journalctl --since "1 hour ago"'
                        alias analize='systemd-analyze'
                        alias poreboot='journalctl -b'
                        alias blame='systemd-analyze blame'
                        alias plot='systemd-analyze plot > bootup.svg'
                        alias orai='~/bin/orai.sh'
                        alias md='~/bin/md.sh'
                        alias search='history | grep -i'
                        alias ping='ping -c 5'
                        alias progresas='~/bin/progresas.sh'
                        alias create_scrip_gui='/home/vaidotak/bin/create_scrip_gui.sh'
                        alias kalendorius='/home/vaidotak/bin/kalendorius.sh'
                        alias disko_vieta='/home/vaidotak/bin/disko_vieta.sh'
                        alias des='/home/vaidotak/bin/des.sh'
                        alias backup='/home/vaidotak/bin/backup.sh'
                        alias gpg_export='/home/vaidotak/bin/gpg_export.sh'
                        alias gpg_import='/home/vaidotak/bin/gpg_import.sh'
                        alias keepassxc_export='/home/vaidotak/bin/keepassxc_export.sh'
                        alias keepass_import='/home/vaidotak/bin/keepass_import.sh'
                        alias valyti_nix='nix-collect-garbage'
                        alias taimeris='systemctl status nixos-upgrade.timer'
                        alias logas='journalctl -u nixos-upgrade.service -e'
                        alias st='systemctl-tui'
                        alias IP='curl ipinfo.io | jq ".ip, .city, .country"'
                        alias USB='./bin/usb_sync.sh'
                        alias SWAP='cat /proc/swaps'
                        alias DF='(df -h | grep -E "/dev/nvme0n1p2|/dev/mmcblk0p1") && free -h | grep Swap'
                        alias zamba='/home/vaidotak/bin/samba.sh'
                        alias dep='/home/vaidotak/bin/dep.sh'
                        alias hm='home-manager switch'
                        alias re='sudo nixos-rebuild switch'

                        # Promptas
                        autoload -U colors && colors
                        PS1="%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[yellow]%}%~%{$reset_color%}> "
    '';
  };
}
