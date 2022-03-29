{ config, pkgs, ... }:

{
  boot.initrd.luks.devices.root = {
      device = "/dev/disk/by-uuid/507fce04-ae14-42c2-9346-d685a5706658";
      allowDiscards = true;
    };

  fileSystems."/" =
    { device = "mainpool/rootfs";
      fsType = "zfs";
    };

  fileSystems."/nix/store" =
    { device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2EA6-312E";
      fsType = "vfat";
    };
}
