{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "nixos"; # Nurodyk savo hostname.
    networkmanager.enable = true;

    nameservers = [
      "1.1.1.1" # Cloudflare DNS
      "1.0.0.1"
      "8.8.8.8" # Google DNS
      "8.8.4.4"
    ];

    dhcpcd.extraConfig = "nohook resolv.conf";
    useNetworkd = true;
    useDHCP = false;
  };

  systemd.services.systemd-networkd.enable = true;

  systemd.network = {
    enable = true;
    networks = {
      "10-wired" = {
        matchConfig.Name = "en*";
        networkConfig = {
          DHCP = "ipv4";
          DNS = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];
          DNSOverTLS = "opportunistic";
        };
        dhcpV4Config.UseDNS = false;
      };
      "20-wireless" = {
        matchConfig.Name = "wl*";
        networkConfig = {
          DHCP = "ipv4";
          DNS = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];
          DNSOverTLS = "opportunistic";
        };
        dhcpV4Config.UseDNS = false;
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 443 21 22 465 993 995 22000 ];
    allowedUDPPorts = [ 21027 3478 3479 3480 3481 ];
    package = pkgs.iptables;
  };

}
