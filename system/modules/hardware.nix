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
  # services.pulseaudio.enable = false;
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

#   fileSystems."/mnt/samba" = {
#   device = "//192.168.1.1/WDCWD10_JPCX24UE4T0_5_60e8";
#   fsType = "cifs";
#   options = [ "guest" "uid=0" "gid=0" "x-systemd.automount" "noauto" "file_mode=0644" "dir_mode=0755"  "x-systemd.device-timeout=1s" ];
# };

# security.sudo.extraRules = [
#   {
#     users = [ "vaidotak" ];
#     commands = [
#       { command = "/usr/bin/umount /mnt/samba"; options = [ "NOPASSWD" ]; }
#       { command = "/usr/bin/mount /mnt/samba"; options = [ "NOPASSWD" ]; }
#     ];
#   }
# ];


}
