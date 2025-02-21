{ config, pkgs, ... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings.server = {
      port = 8080;
      bind_address = "127.0.0.1";
      secret_key = "secret key";
    };
  };

}
