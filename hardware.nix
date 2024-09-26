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
}