{ config, pkgs, ... }:

let
  secrets = import /home/vaidotak/bin/secret.nix;
  homeDir = "/home/vaidotak";

in {
  services.syncthing = {
    enable = true;
    group = "vaidotak";
    user = "vaidotak";
    dataDir = "/home/vaidotak/.syncthing";
    configDir = "/home/vaidotak/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      gui = { address = "127.0.0.1:8384"; };
      devices = { "samsungS24" = { id = secrets.syncthingDeviceID; }; };
      folders = {
        "obsidian" = {
          path = "${homeDir}/Obsidian";
          devices = [ "samsungS24" ];
        };
        "gpg_backup" = {
          path = "${homeDir}/.backup";
          devices = [ "samsungS24" ];
          ignorePerms = false;
        };
        "bin" = {
          path = "${homeDir}/bin";
          devices = [ "samsungS24" ];
        };
        # "nixos" = {
        #   path = "${homeDir}/nixos";
        #   devices = [ "samsungS24" ];
        #   type = "sendonly";
        # };
        "audiobooks" = {
          path = "${homeDir}/syncthing/audiobooks";
          devices = [ "samsungS24" ];
          type = "sendonly";
        };
        "other" = {
          path = "${homeDir}/syncthing/other";
          devices = [ "samsungS24" ];
        };
        "video" = {
          path = "${homeDir}/syncthing/video";
          devices = [ "samsungS24" ];
        };
        # "config" = {
        #   path = "${homeDir}/.config";
        #   devices = [ "samsungS22" ];
        # };
      };
    };
  };
}
