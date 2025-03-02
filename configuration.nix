{ config, pkgs, ... }: {
  # Įtraukiame visus modulinius failus
  imports = [
    ./system/modules/hardware.nix
    ./system/modules/software.nix
    ./system/modules/users.nix
    ./system/modules/updates.nix
    ./system/modules/services.nix
    ./system/modules/networking.nix
    ./system/modules/desktop.nix
    ./system/modules/hardware-configuration.nix
    ./system/modules/syncthing.nix
    <home-manager/nixos>
  ];

home-manager = {
    # useGlobalPkgs = true;    # Naudoti globalius paketus
    useUserPackages = true;  # Įdiegti paketus į naudotojo profilį
    users.vaidotak = import /home/vaidotak/nixos/home.nix;
    # backupFileExtension = "backup-new";
  };
  

  # Boot loader konfigūracija
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

  # Branduolio parametrų nustatymai
  boot.kernelParams = [
    "kernel.panic=10" # Perkrauna sistemą po 10 s kernel panic
    "loglevel=7" # Išsamūs logai
    "earlyprintk" # Ankstyvas spausdinimas į konsolę
    "kernel.panic_on_oops=1" # Perkrauna sistemą, jei įvyksta oops
    "kernel.core_pattern=/var/crash/core.%e.%p" # Crash dump failo kelias
    "acpi_osi=!"
    ''acpi_osi="Windows 2009"''
    "acpi=force"
  ];

  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  # Aparatinės įrangos konfigūracija
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # Laiko ir lokalizacijos nustatymai
  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "lt_LT.UTF-8";
  environment.variables.LC_ALL = "lt_LT.UTF-8";

  security.rtkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" ];

  system.stateVersion = "24.11";
}
