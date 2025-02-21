{ config, pkgs, ... }:

{
  users.groups.vaidotak = {};

  users.users.vaidotak = {
    isNormalUser = true;
    description = "Vaidotak";
    extraGroups = [ "networkmanager" "wheel" "vaidotak" "users" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
