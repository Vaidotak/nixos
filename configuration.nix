{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./networking.nix
    # ./desktop.nix
    # ./users.nix
    # ./software.nix
    # ./hardware.nix
    # ./updates.nix
    # ./services.nix
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

  # Kernel parameters
  boot.kernelParams = [
    # "sysrq=1"        # Įgalina Magic SysRq
    "kernel.panic=10" # Perkrauna sistemą po 10 sekundžių kernel panic
    "loglevel=7" # Išsamūs logai (aukščiausias lygis)
    "earlyprintk" # Ankstyvas spausdinimas į konsolę
    "kernel.panic_on_oops=1" # Perkrauna sistemą, jei įvyksta oops (branduolio klaida)
    "kernel.core_pattern=/var/crash/core.%e.%p" # Nustato crash dump failo išsaugojimo vietą
    "acpi_osi=Linux"
  ];

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
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
  environment.variables.LC_ALL = "lt_LT.UTF-8";

  # Security settings
  security.rtkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System state version
  system.stateVersion = "24.11";
}
