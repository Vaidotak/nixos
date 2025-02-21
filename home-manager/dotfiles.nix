{ config, pkgs, ... }:

{
   home.file.".config/lsd/config.yaml".source = ./dotfiles/lsd-config.yaml;
}