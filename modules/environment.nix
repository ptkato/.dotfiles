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
    pulseaudio.enable       = false;
    # pulseaudio.support32Bit = true;
    # pulseaudio.package      = pkgs.pulseaudioFull;
    # pulseaudio.extraConfig  = ''
    #  # load-module module-loopback latency_msec=1
    #  .ifexists module-echo-cancel.so
    #    load-module module-echo-cancel aec_method=webrtc source_name=echocancel sink_name=echocancel1 aec_args="analog_gain_control=0 digital_gain_control=0"
    #    set-default-source echocancel
    #    set-default-sink echocancel1
    #  .endif
    # '';

    opengl = {
      enable          = true;
      package         = pkgs.mesa.drivers;
      package32       = pkgs.pkgsi686Linux.mesa.drivers;
      driSupport      = true;
      driSupport32Bit = true;
      extraPackages   = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };

    bluetooth = {
      enable  = true;
      package = pkgs.bluez;
    };

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      enableSSHSupport = true;
  };

  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
    gpuOverclock.ppfeaturemask = "0xffffffff";
  };

  programs.java = {
    enable = true;
    package = pkgs.jetbrains.jdk;
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.corectrl.helper.init" ||
             action.id == "org.corectrl.helperkiller.init") &&
          subject.local == true &&
          subject.active == true &&
          subject.isInGroup("your-user-group")) {
            return polkit.Result.YES;
        }
      });
    '';
  };

  services = {
    pipewire = {
      enable               = true;
      alsa.enable          = true;
      alsa.support32Bit    = true;
      pulse.enable         = true;
      jack.enable          = true;
      # media-session.enable = true;
      # wireplumber.enable   = false;
    };

    ratbagd.enable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebkit-5.212.0-alpha4"
  ];

  environment.shellInit      = "export GTK_DATA_PREFIX=${config.system.path}";
  environment.pathsToLink    = [
    "share/thumbnailers"
  ];
  environment.systemPackages = with pkgs; [
    virt-manager
    mesa vulkan-tools vulkan-loader vulkan-headers

    parted tree lshw vim htop usbutils
    wget curl killall git pciutils
    easyeffects pulseaudio
    libratbag piper corectrl
    gnupg pinentry-gnome3

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
    gnome.evince
    gnome.eog

    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.appindicator
  ];
}
