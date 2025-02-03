{
  config,
  pkgs,
  lib,
  ...
}:

let
  secrets = import /home/vaidotak/.config/syncthing/secret.nix;
in
{
  networking = {
    hostName = "nixos";

    nameservers = [
      "1.1.1.1" # Cloudflare DNS
      "1.0.0.1"
      "8.8.8.8" # Google DNS
      "8.8.4.4"
    ];

    useNetworkd = true; # Naudojame systemd tinklų valdymui.
    useDHCP = false; # DHCP konfigūruojamas rankiniu būdu.

    dhcpcd.extraConfig = ''
      nohook resolv.conf
      interface wlo1
      option domain_name_servers '1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4'
    '';
  };

  systemd.network = {
    enable = true;
    networks = {
      "10-wired" = {
        matchConfig.Name = "en*";
        networkConfig = {
          DHCP = "ipv4";
          DNS = [
            "1.1.1.1"
            "1.0.0.1"
            "8.8.8.8"
            "8.8.4.4"
          ];
        };
        dhcpV4Config.UseDNS = false;
      };
      "20-wireless" = {
        matchConfig.Name = "wl*";
        networkConfig = {
          DHCP = "ipv4";
          DNS = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ]; # Pridėta čia
        };
      };
    };
  };

  # Įdiegiame ir sukonfigūruojame wpa_supplicant
  environment.systemPackages = with pkgs; [ wpa_supplicant ];

  systemd.services.wpa_supplicant = {
    enable = true;
    description = "WPA Supplicant Service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wpa_supplicant}/bin/wpa_supplicant -c /etc/wpa_supplicant.conf -i wlo1";
      Restart = "always";
    };
  };

  # wpa_supplicant konfigūracija (pasiekiama iš /etc/wpa_supplicant.conf)
  systemd.tmpfiles.rules = [
    "f /etc/wpa_supplicant.conf 600 root root"
  ];

  environment.etc = {
    "wpa_supplicant.conf".text = ''
      ctrl_interface=/run/wpa_supplicant
      update_config=1

      network={
        ssid="Django"
        psk="${secrets.SSID1}"
        priority=100
      }

      network={
        ssid="bruh"
        psk="${secrets.SSID2}"
        priority=50
      }

      network={
        ssid="Galaxy S23 ultra"
        psk="${secrets.SSID3}"
        priority=100
      }
    '';
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      443
      21
      22
      465
      993
      995
      22000
      139
      445
    ];
    allowedUDPPorts = [
      21027
      3478
      3479
      3480
      3481
    ];
    package = pkgs.iptables;
  };
}
