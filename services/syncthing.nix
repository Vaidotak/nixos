{ config, pkgs, ... }:

let
  secrets = import /home/vaidotak/.config/syncthing/secret.nix;
in {
  services = {
    syncthing = {
      enable = true;
      group = "vaidotak";
      user = "vaidotak";
      dataDir = "/home/vaidotak/.syncthing";
      configDir = "/home/vaidotak/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        gui = {
          address = "127.0.0.1:8384";
        };
        devices = {
          "samsungS22" = { id = secrets.syncthingDeviceID; }; # Panaudojamas ID iš secret.nix
          # "device2" = { id = "DEVICE-ID-GOES-HERE"; };
        };
        folders = {
          "obsidian" = {
            path = "/home/vaidotak/Obsidian"; # Which folder to add to Syncthing
            devices = [ "samsungS22" ]; # Which devices to share the folder with
          };
          "gpg_backup" = {
            path = "/home/vaidotak/.backup";
            devices = [ "samsungS22" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
          "bin" = {
            path = "/home/vaidotak/bin";
            devices = [ "samsungS22" ];
          };
          "config" = {
            path = "/home/vaidotak/.config"; # Which folder to add to Syncthing
            devices = [ "samsungS22" ]; # Which devices to share the folder with
          };
        };
      };
    };
  };
}
