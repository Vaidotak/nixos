{ config, pkgs, ... }:

let
  secrets = import /home/vaidotak/.config/syncthing/secret.nix;
in {
  programs.filezilla = {
  enable = true;
  settings = {
    FileZilla3 = {
      Servers = {
        Server = [
          {
            Host = secrets.filezilla.host;
            Port = "22";
            Protocol = "0";
            Type = "0";
            User = secrets.filezilla.user;
            Pass = secrets.filezilla.pass;
            Name = "Knygų serveris";
            RemoteDir = secrets.filezilla.remoteDir;
          }
        ];
      };
    };
  };
};
}