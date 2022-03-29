{ config, pkgs, ... }:

{
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    enable       = true;
    autorun      = true;

    displayManager.gdm.enable      = true;
    displayManager.gdm.autoSuspend = false;
    desktopManager.gnome.enable    = true;

    layout = "br";
    # libintput.enable = true;
  };

  console.useXkbConfig = true;
  i18n.defaultLocale   = "en_US.UTF-8";
  time.timeZone        = "America/Sao_Paulo";

  sound.enable = true;
  hardware = {
    pulseaudio.enable       = true;
    pulseaudio.support32Bit = true;
    pulseaudio.package      = pkgs.pulseaudioFull;
    # pulseaudio.extraConfig = "load-module module-loopback latency_msec=1";

    opengl = {
      enable          = true;
      package         = pkgs.mesa.drivers;
      package32       = pkgs.pkgsi686Linux.mesa.drivers;
      driSupport      = true;
      driSupport32Bit = true;
    };
  };

  services = {
    # pipewire.media-session.enable = true;
    # pipewire.wireplumber.enable   = false;

    ratbagd.enable = true;
  };

  environment.shellInit      = "export GTK_DATA_PREFIX=${config.system.path}";
  environment.systemPackages = with pkgs; [
    mesa vulkan-tools vulkan-loader vulkan-headers

    parted tree lshw vim htop 
    wget curl killall git pciutils

    gnome.gdm
    gnome.gnome-shell
    gnome.gnome-session

    gnome.gvfs
    gnome.dconf-editor
    gnome.adwaita-icon-theme
    gnome.gnome-screenshot
    gnome.gnome-weather
    gnome.gnome-tweaks
    gnome.nautilus
    gnome.eog

    gnomeExtensions.tray-icons-reloaded
  ];
}