{ config, pkgs, ... }:

{
home.packages = with pkgs; [

    neofetch
    nnn

  ];

  #2024.12.26
  home.username = "vaidotak";
  home.homeDirectory = "/home/vaidotak";

  
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
