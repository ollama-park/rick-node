{ config, pkgs, ... }:

let
  wgEndpointIP = "167.71.46.121";
  defaultIface = "enp1s0";
  defaultGtw = "192.168.1.1";
in
{
  age.secrets.wg-rick.file = ./secrets/wg-rick.age;
  age.identityPaths = [ "/root/.ssh/rick" ];

  networking.wireguard.enable = true;

  networking.wireguard.interfaces.wg0 = {
    ips = [ "172.16.45.2/24" ];

    privateKeyFile = config.age.secrets.wg-rick.path;

    peers = [
      {
        name = "asshole-vps";
        publicKey = "bXm95yJy9KNd0lqQqQso+y8oSiJRfSc76A1g0jcDiHE=";

        allowedIPs = [ "0.0.0.0/0" ];

        endpoint = "${wgEndpointIP}:51820";
        persistentKeepalive = 25;
      }
    ];

    postSetup = ''
      ${pkgs.iproute2}/bin/ip route add ${wgEndpointIP} \
        via ${defaultGtw} \
        dev ${defaultIface}
    '';

    postShutdown = ''
      ${pkgs.iproute2}/bin/ip route del ${wgEndpointIP} \
        via ${defaultGtw} \
        dev ${defaultIface}
    '';
  };
}

