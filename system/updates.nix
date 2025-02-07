{ config, pkgs, lib, ... }:

{
  # Automatinis sistemos atnaujinimas
  system.autoUpgrade = {
    enable = true;
    flags = [ "--upgrade" ];
    dates = "09:00";
    randomizedDelaySec = "10min";
    allowReboot = false;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };

  # Automatinė šiukšlių kolekcija
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Nix saugyklos optimizavimas
  nix.settings.auto-optimise-store = true;
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # Sistemos atnaujinimo tvarkaraštis
  systemd.timers."nixos-upgrade" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "10min";
      OnUnitActiveSec = "1d";
      Unit = "nixos-upgrade.service";
    };
  };
}
