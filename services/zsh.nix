{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    shellInit = ''
      # Aplinkos kintamieji
      export EDITOR=code
      export VISUAL=code
      export BROWSER=firefox
      export PAGER=less
    '';

    interactiveShellInit = ''
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
      alias analize='systemd-analyze' # yra įrankis, skirtas analizuoti sistemos paleidimo našumą ir gauti kitokią informaciją iš systemd sistemos valdytojo. Ši komanda naudinga sprendžiant problemas, susijusias su ilgu paleidimo laiku ar norint suprasti, kurios paslaugos užima daugiausiai laiko sistemos paleidimo metu.
      alias poreboot='journalctl -b' # Rodo žurnalo įrašus nuo paskutinio paleidimo
      alias blame='systemd-analyze blame' # Ši komanda bando nustatyti, kas sulėtina sistemos paleidimą. Ji pateikia informaciją apie paslaugas, kurios uždelsia kitų paslaugų paleidimą
      alias plot='systemd-analyze plot >bootup.svg'
      alias orai='~/bin/orai.sh'
      alias oraimd='./o.sh > /home/vaidotak/Obsidian/notes/Oras.md'
      alias md='~/bin/md.sh'
      alias mpeg='~/bin/ffmpeg.sh'
      alias cmd='~/komandos.sh'
      alias search='history | grep -i'
      alias ping='ping -c 5'
      alias progresas='~/bin/progresas.sh'
      alias transfer='~/bin/transfer.sh'
      alias create_scrip_gui='/home/vaidotak/bin/create_scrip_gui.sh'
      alias rutracker_rss_i_obsidian='/home/vaidotak/bin//rutracker_rss_i_obsidian.sh'
      alias kalendorius='/home/vaidotak/bin//kalendorius.sh'
      alias bashbar='/home/vaidotak/bin//bashbar.sh'
      alias notify_send='/home/vaidotak/bin//notify_send.sh'
      alias faktai='/home/vaidotak/bin//faktai.sh'
      alias regular='/home/vaidotak/bin//regular.sh'
      alias pdf2txt='/home/vaidotak/bin//pdf2txt.sh'
      alias mokesciai='/home/vaidotak/bin//mokesciai.sh'
      alias rasti_programas='/home/vaidotak/bin//rasti_programas.sh'
      alias programu_instaliavimas='/home/vaidotak/bin//programu_instaliavimas.sh'
      alias internetas='/home/vaidotak/bin//internetas.sh'
      alias patikra='/home/vaidotak/bin//patikra.sh'
      alias internetas_c='/home/vaidotak/bin//internetas_c.sh'
      alias disko_vieta='/home/vaidotak/bin//disko_vieta.sh'
      alias des='/home/vaidotak/bin//des.sh'
      alias backup='/home/vaidotak/bin//backup.sh'
      alias create_syncthing_servise='/home/vaidotak/bin//create_syncthing_servise.sh'
      alias sudo_stars='/home/vaidotak/bin//sudo_stars.sh'
      alias gpg_export='/home/vaidotak/bin//gpg_export.sh'
      alias gpg_import='/home/vaidotak/bin//gpg_import.sh'
      alias keepassxc_export='/home/vaidotak/bin//keepassxc_export.sh'
      alias keepass_import='/home/vaidotak/bin//keepass_import.sh'
      alias sync_nix='/home/vaidotak/bin//sync_nix.sh'
      alias nixconf_script='/home/vaidotak/bin//nixconf_script.sh'
      alias redaguoti_nix='sudoedit /etc/nixos/configuration.nix'
      alias atnaujinti_nix='sudo nixos-rebuild switch'
      alias konvertuoti_hosts='/home/vaidotak/bin//konvertuoti_hosts.sh'
      alias valyti_nix='nix-collect-garbage'
      alias taimeris='systemctl status nixos-upgrade.timer' # parodo upgreido taimerį
      alias logas='journalctl -u nixos-upgrade.service -e' # parodo upgreido žurnalą
      alias st='systemctl-tui'
      alias IP='curl ipinfo.io | jq ".ip, .city, .country"'
      alias USB='./bin/usb_sync.sh'
      alias SWAP='cat /proc/swaps'
      alias DF='(df -h | grep -E "/dev/nvme0n1p2|/dev/mmcblk0p1") && free -h | grep Swap'
      alias zamba='/home/vaidotak/bin//samba.sh'
      alias nixgit='git --git-dir=$HOME/nix_git/ --work-tree=/etc/nixos'
      alias deploy='/home/vaidotak/bin//deploy.sh'
    '';

    promptInit = ''
      autoload -U colors && colors
      PS1="%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[yellow]%}%~%{$reset_color%}> "
    '';

    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
}
