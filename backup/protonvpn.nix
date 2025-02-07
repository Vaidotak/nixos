{ config, pkgs, ... }:

{

  systemd.services.protonvpn-autoconnect = {
    description = "ProtonVPN autoconnect";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [
      protonvpn-cli
      python3
      python3Packages.pygobject3
      glib
      gobject-introspection
    ];
    environment = {
      GI_TYPELIB_PATH = "${pkgs.gobject-introspection}/lib/girepository-1.0";
      LD_LIBRARY_PATH = "${pkgs.glib}/lib";
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.protonvpn-cli}/bin/protonvpn-cli connect --fastest NL";
      User = "root";
    };
  };

}
