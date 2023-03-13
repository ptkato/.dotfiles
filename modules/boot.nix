{ config, pkgs, ... }:

{
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelModules  = [ "kvm-amd" ];
    kernelParams   = [ "nohibernate" ];

    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    initrd.kernelModules          = [ "amdgpu" ];

    supportedFilesystems = [ "ntfs" ];
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable                = true;
    version               = 2;
    device                = "nodev";
    efiSupport            = true;
    efiInstallAsRemovable = true;
  };
}
