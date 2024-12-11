{ config, pkgs, ... }:

{
  users.users.vaidotak = {
    isNormalUser = true;
    description = "Vaidotak";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
