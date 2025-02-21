{ config, pkgs, ... }:
let
  secrets = import ./secret.nix;
in {
  services.syncthing = {
    enable = true;
    extraOptions = [ "--no-browser" "--no-restart" "--no-upgrade" ];
    settings = {
      gui = {
        enabled = true;
        tls = false;
        address = "127.0.0.1:8384";
        theme = "default";
      };
      options = {
        localAnnounceEnabled = true;
        globalAnnounceEnabled = false;
        relaysEnabled = false;
        urAccepted = -1;
        maxFolderConcurrency = 10;
        reconnectionIntervalS = 60;
        limitBandwidthInLan = false;
      };
      devices = {
        samsungS22 = {
          id = secrets.syncthingDeviceID;
          name = "samsungS22";
          compression = "metadata";
        };
      };
      folders = {
        obsidian = {
          label = "Obsidian Notes";
          path = "/home/vaidotak/Obsidian";
          type = "sendreceive";
          rescanIntervalS = 3600;
          devices = [ "samsungS22" ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
        gpg_backup = {
          label = "GPG Backup";
          path = "/home/vaidotak/.backup";
          type = "sendreceive";
          rescanIntervalS = 3600;
          devices = [ "samsungS22" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "31536000";
            };
          };
        };
        bin = {
          label = "Scripts & Binaries";
          path = "/home/vaidotak/bin";
          type = "sendreceive";
          rescanIntervalS = 3600;
          devices = [ "samsungS22" ];
          versioning = {
            type = "simple";
            params = {
              keep = "5";
            };
          };
        };
        config = {
          label = "Configuration Files";
          path = "/home/vaidotak/.config";
          type = "sendreceive";
          rescanIntervalS = 3600;
          devices = [ "samsungS22" ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
      };
    };
  };
}