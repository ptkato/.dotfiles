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
    pulseaudio.extraConfig  = ''
      # load-module module-loopback latency_msec=1
      load-module module-alsa-sink device="hdmi:CARD=HDMI,DEV=0" sink_name=HDMI0Right
      load-module module-alsa-sink device="hdmi:CARD=HDMI,DEV=3" sink_name=HDMI3Bottom
      load-module module-alsa-sink device="hdmi:CARD=HDMI,DEV=4" sink_name=HDMI4Top
      load-module module-alsa-sink device="hdmi:CARD=HDMI,DEV=5" sink_name=HDMI5Left
      load-module module-alsa-sink device="front:CARD=Generic,DEV=0" sink_name=Headphones
      load-module module-combine-sink sink_name=AllHDMI slaves=HDMI0Right,HDMI3Bottom,HDMI4Top,HDMI5Left
      load-module module-combine-sink sink_name=AllOutputs slaves=AllHDMI,Headphones
    '';

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

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebkit-5.212.0-alpha4"
  ];

  environment.shellInit      = "export GTK_DATA_PREFIX=${config.system.path}";
  environment.systemPackages = with pkgs; [
    virt-manager
    mesa vulkan-tools vulkan-loader vulkan-headers

    parted tree lshw vim htop usbutils
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
