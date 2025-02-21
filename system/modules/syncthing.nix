{ config, pkgs, ... }:

let
  secrets = import /home/vaidotak/bin/secret.nix;
in 

{
  services.syncthing = {
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
      "samsungS22" = {  
        id = secrets.syncthingDeviceID;
      };
        };
        folders = {
          "obsidian" = {
            path = "/home/vaidotak/Obsidian"; 
            devices = [ "samsungS22" ]; 
          };
          "gpg_backup" = {
            path = "/home/vaidotak/.backup";
            devices = [ "samsungS22" ];
            ignorePerms = false; 
          };
          "bin" = {
            path = "/home/vaidotak/bin";
            devices = [ "samsungS22" ];
          };
          "nixos" = {
            path = "/home/vaidotak/nixos";
            devices = [ "samsungS22" ];
          };
          "config" = {
            path = "/home/vaidotak/.config"; 
            devices = [ "samsungS22" ]; 
          };
        };
      };
    };
}
