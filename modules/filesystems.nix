{ config, pkgs, ... }:

{
  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

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

  fileSystems."/home/ptkato/extra" =
    { device = "/dev/disk/by-uuid/5fe39236-028c-4642-a5d4-85c00bbbacc3";
      fsType = "ext4";
    };
}
