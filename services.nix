{ config, pkgs, ... }:

{
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

  services.espanso = {
    enable = true;
    package = pkgs.espanso;
  };

   services.prometheus = {
    enable = true;
    globalConfig.scrape_interval = "10s"; # "1m"
    scrapeConfigs = [
    {
      job_name = "node";
      static_configs = [{
        targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
      }];
    }
    ];
  };

services.grafana = {
  enable = true;
  settings = {
    server = {
      http_addr = "127.0.0.1";
      http_port = 3000;
      enforce_domain = false;
      enable_gzip = true;
    };
  };
};

services.prometheus.exporters.node = {
  enable = true;
  port = 9100;
};


}
