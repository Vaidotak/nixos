{ config, pkgs, ... }:
let
  secrets = import /home/vaidotak/.config/syncthing/secret.nix;
in {
  programs.filezilla = {
    enable = true;
    settings = {
      "Servers" = {
        "Server" = [
          {
            "Host" = secrets.filezilla.host;
            "Port" = "22";
            "Protocol" = "0";
            "Type" = "0";
            "User" = secrets.filezilla.user;
            "Pass" = secrets.filezilla.pass;
            "Name" = "Knygų serveris";
            "RemoteDir" = secrets.filezilla.remoteDir;
          }
        ];
      };
    };
  };

  users.users.vaidotak = {
    isNormalUser = true;
    extraFiles = {
      ".config/filezilla/sitemanager.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <FileZilla3>
          <Servers>
            <Server>
              <Host>${secrets.filezilla.host}</Host>
              <Port>22</Port>
              <Protocol>0</Protocol>
              <Type>0</Type>
              <User>${secrets.filezilla.user}</User>
              <Pass>${secrets.filezilla.pass}</Pass>
              <Name>Knygų serveris</Name>
              <RemoteDir>${secrets.filezilla.remoteDir}</RemoteDir>
            </Server>
          </Servers>
        </FileZilla3>
      '';
    };
  };
}
