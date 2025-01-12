{ config, pkgs, ... }:

{
  users.groups.vaidotak = {};

  users.users.vaidotak = {
    isNormalUser = true;
    description = "Vaidotak";
    extraGroups = [ "networkmanager" "wheel" "vaidotak" "users" ];
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
