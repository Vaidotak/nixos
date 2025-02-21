{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking = {
    hostName = "nixos";
    nameservers = [
      "1.1.1.1" # Cloudflare DNS
      "1.0.0.1"
      "8.8.8.8" # Google DNS
      "8.8.4.4"
    ];
    useNetworkd = false;
  };

  # Teisingas NetworkManager įjungimas
  networking.networkmanager.enable = true;  # Atkreipkite dėmesį į "networkmanager" vietoj "network-manager"

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