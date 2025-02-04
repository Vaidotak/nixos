{ config, pkgs, ... }:

{
  users.groups.vaidotak = {};

  users.users.vaidotak = {
    isNormalUser = true;
    description = "Vaidotak";
    extraGroups = [ "networkmanager" "wheel" "vaidotak" "users" ];
    shell = pkgs.zsh;
  };
  
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

    # Jūsų aliases
    alias ll='ls -la'
    alias la='ls -A'
    # Pridėkite daugiau alias'ų čia...
  '';

  promptInit = ''
    autoload -U colors && colors
    PS1="%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[cyan]%}%~%{$reset_color%}> "
  '';

  syntaxHighlighting.enable = true;
  autosuggestions.enable = true;
};

  systemd.user.services.syncthing = { 
    description = "Syncthing service";
    wantedBy = [ "default.target" ]; 
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.syncthing}/bin/syncthing -no-browser -gui-address=127.0.0.1:8384"; 
      Restart = "on-failure";
      Type = "simple";
      User = "vaidotak";
      Group = "vaidotak";
    };
    environment = {
        SYNCTHING_CONFIG_DIR = "/home/vaidotak/.config/syncthing";
        SYNCTHING_DATA_DIR = "/home/vaidotak/.local/share/syncthing";
    };
  };
}
