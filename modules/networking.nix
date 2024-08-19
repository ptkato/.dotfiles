{ config, pkgs, ... }:

{
  services.dnsmasq.extraConfig = "cache-size=1000";

  networking = {
    firewall.enable       = false;
    wireless.enable       = false;
    networkmanager.enable = true;

    networkmanager.dns  = "dnsmasq";
    # networkmanager.dhcp = "dhcpcd";

    hostName = "ptkato-desktop";
    hostId   = "13d3cba0";

    useDHCP                   = false;
    interfaces.enp5s0.useDHCP = true;
  };
}
