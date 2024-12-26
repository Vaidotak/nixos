{ config, pkgs, ... }:

let
  # Importuojame samba-paths naudojant santykinį kelią
  sambaPaths = import ./configs/samba-paths.nix;
in
{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "server min protocol" = "SMB2";
        "server max protocol" = "SMB3";
        "encrypt passwords" = "yes";
        #"smb encrypt" = "required";
        #"workgroup" = "WORKGROUP";
        "log level" = "2";
        "log file" = "/home/vaidotak/samba/log.%m";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      movies = {
        "path" = sambaPaths.sambaPaths.moviesPath;
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "hosts allow" = "192.168.1.206 192.168.1.242"; # Android TV
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "vaidotak";
        "force group" = "users";
      };

      videos = {
        "path" = sambaPaths.sambaPaths.videoPath;
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "hosts allow" = "192.168.1.206 192.168.1.242"; # Android TV
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "vaidotak";
        "force group" = "users";
      };
    };
  };

  services.espanso = {
    enable = true;
    package = pkgs.espanso;
  };

  services.flatpak.enable = true;

  # Laikinai nereikalingi

  #  services.syncthing.enable = true;
  #  services.syncthing.user = "vaidotak";
  #  virtualisation.docker.enable = true;

  #  NixOS SearXNG servisai
  #  services.searx.enable = true;
  #  services.searx.settings.server.secret_key = "slaptas_raktas";
  #  services.searx.settings.server.port = 8080;
  #  services.searx.settings.search.formats = [ "html" "json" "rss" ];

  #  services.openssh.enable = true;

  # services.prometheus = {
  #   enable = true;
  #   globalConfig.scrape_interval = "10s"; # "1m"
  #   scrapeConfigs = [
  #     {
  #       job_name = "node";
  #       static_configs = [{
  #         targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
  #       }];
  #     }
  #   ];
  # };

  # services.grafana = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       http_addr = "127.0.0.1";
  #       http_port = 3000;
  #       enforce_domain = false;
  #       enable_gzip = true;
  #     };
  #   };
  # };

  # services.prometheus.exporters.node = {
  #   enable = true;
  #   port = 9100;
  # };

}
