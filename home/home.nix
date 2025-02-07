{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh-config.nix
  ];

  home.username = "vaidotak";
  home.homeDirectory = "/home/vaidotak";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zsh # Z shell
    zsh-syntax-highlighting # Z shell sintaksės paryškinimas
    zsh-autosuggestions # Z shell automatiniai pasiūlymai
  ];

  home.stateVersion = "24.11";
}