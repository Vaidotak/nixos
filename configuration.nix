{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./desktop.nix
    ./users.nix
    ./software.nix
    ./hardware.nix
    ./updates.nix
  ];

  # Boot loader configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub = {
      extraConfig = ''
        set gfxpayload=keep
      '';
      configurationLimit = 3;
    };
  };

  # Hardware configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # Time and localization settings
  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "lt_LT.UTF-8";

  # Security settings
  security.rtkit.enable = true;

  # System state version
  system.stateVersion = "24.05";
}