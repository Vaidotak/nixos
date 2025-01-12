{ config, pkgs, ... }:

{
  users.groups.vaidotak = {};

  users.users.vaidotak = {
    isNormalUser = true;
    description = "Vaidotak";
    extraGroups = [ "networkmanager" "wheel" "vaidotak" "users" ];
  };
  systemd.user.services.syncthing = { # ČIA SVARBIAUSIAS PAKEITIMAS
    description = "Syncthing service";
    wantedBy = [ "default.target" ]; # Paleidžiama vartotojo sesijos metu
    partOf = [ "graphical-session.target" ]; # Priklauso grafinei sesijai
    serviceConfig = {
      ExecStart = "${pkgs.syncthing}/bin/syncthing -no-browser -gui-address=127.0.0.1:8384"; # Nurodome pilną kelią iki syncthing
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
