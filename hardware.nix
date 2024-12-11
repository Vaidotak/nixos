{ config, pkgs, ... }:

{
  swapDevices = [
    {
      device = "/swapfile";
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.pipewire.extraConfig.pipewire = {
    "99-disable-bell" = {
      "context.properties" = {
        "module.x11.bell" = false;
      };
    };
  };
}
