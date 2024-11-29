{ config, pkgs, ... }:

{
  #  services.syncthing.enable = true;
  #  services.syncthing.user = "vaidotak";

# virtualisation.docker.enable = true;

#NixOS SearXNG servisai
  services.searx.enable = true;
  services.searx.settings.server.secret_key = "slaptas_raktas";
  services.searx.settings.server.port = 8080;
  services.searx.settings.search.formats = ["html" "json" "rss"];
}