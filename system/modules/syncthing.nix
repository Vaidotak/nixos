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
      devices = { "samsungS22" = { id = secrets.syncthingDeviceID; }; };
      folders = {
        "obsidian" = {
          path = "${homeDir}/Obsidian";
          devices = [ "samsungS22" ];
        };
        "gpg_backup" = {
          path = "${homeDir}/.backup";
          devices = [ "samsungS22" ];
          ignorePerms = false;
        };
        "bin" = {
          path = "${homeDir}/bin";
          devices = [ "samsungS22" ];
        };
        "nixos" = {
          path = "${homeDir}/nixos";
          devices = [ "samsungS22" ];
          type = "sendonly";
        };
        # "config" = {
        #   path = "${homeDir}/.config";
        #   devices = [ "samsungS22" ];
        # };
      };
    };
  };
}
