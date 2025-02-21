{ config, pkgs, ... }:

let
  secrets = import /home/vaidotak/bin/secret.nix;
in {
  devices = {
    "samsungS22" = { id = secrets.syncthingDeviceID; };
    # "device2" = { id = "DEVICE-ID-GOES-HERE"; };
  };
}