{ config, pkgs, ... }:

{
  systemd.user.services.backup = {
    description = "Backup Service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/vaidotak/bin/failu_kopijos.sh";
    };
  };

  systemd.user.timers.backup = {
    description = "Backup Timer";
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
