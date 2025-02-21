{ config, pkgs, ... }:

{
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
    "config" = {
      path = "/home/vaidotak/.config";
      devices = [ "samsungS22" ];
    };
  };
}