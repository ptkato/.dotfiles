{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
   # kernelModules = [ "kvm-amd" ];
    initrd.kernelModules = [ "amdgpu" ];
   # kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "ptkato-desktop"; 

  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  fonts = {
    enableDefaultFonts = true;
  #  fontDir.enable = true;
    fonts = with pkgs; [
      corefonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      roboto-mono
      google-fonts
      powerline-fonts
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console = {
    font = "Roboto Mono";
    useXkbConfig = true;
  };

  time.timeZone = "America/Sao_Paulo";

  programs = {
    vim.defaultEditor = true;
    bash.interactiveShellInit = ''
      powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
      POWERLINE_BASH_SELECT=1
      . /etc/profiles/per-user/patrick/share/bash/powerline.sh
    '';
  };

  environment = {
    systemPackages = with pkgs; [
      firefox
      gnome3.gnome-tweaks
      gnome3.adwaita-icon-theme
      gnome3.gnome-screenshot
      parted
    ];

    shellInit = ''
      export GTK_DATA_PREFIX=${config.system.path}
    '';
  };

  nix = {
    autoOptimiseStore = true;
    binaryCaches = [ "https://nixcache.reflex-frp.org" ];
    binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  virtualisation = {
    docker.enable = true;
   # virtualbox.host.enable = true;
  };

  networking.firewall.enable = false;

  security.pki = {
    certificates = [
      ''
        -----BEGIN CERTIFICATE-----
        MIIEIDCCAwigAwIBAgIQNE7VVyDV7exJ9C/ON9srbTANBgkqhkiG9w0BAQUFADCB
        qTELMAkGA1UEBhMCVVMxFTATBgNVBAoTDHRoYXd0ZSwgSW5jLjEoMCYGA1UECxMf
        Q2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjE4MDYGA1UECxMvKGMpIDIw
        MDYgdGhhd3RlLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxHzAdBgNV
        BAMTFnRoYXd0ZSBQcmltYXJ5IFJvb3QgQ0EwHhcNMDYxMTE3MDAwMDAwWhcNMzYw
        NzE2MjM1OTU5WjCBqTELMAkGA1UEBhMCVVMxFTATBgNVBAoTDHRoYXd0ZSwgSW5j
        LjEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjE4MDYG
        A1UECxMvKGMpIDIwMDYgdGhhd3RlLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNl
        IG9ubHkxHzAdBgNVBAMTFnRoYXd0ZSBQcmltYXJ5IFJvb3QgQ0EwggEiMA0GCSqG
        SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCsoPD7gFnUnMekz52hWXMJEEUMDSxuaPFs
        W0hoSVk3/AszGcJ3f8wQLZU0HObrTQmnHNK4yZc2AreJ1CRfBsDMRJSUjQJib+ta
        3RGNKJpchJAQeg29dGYvajig4tVUROsdB58Hum/u6f1OCyn1PoSgAfGcq/gcfomk
        6KHYcWUNo1F77rzSImANuVud37r8UVsLr5iy6S7pBOhih94ryNdOwUxkHt3Ph1i6
        Sk/KaAcdHJ1KxtUvkcx8cXIcxcBn6zL9yZJclNqFwJu/U30rCfSMnZEfl2pSy94J
        NqR32HuHUETVPm4pafs5SSYeCaWAe0At6+gnhcn+Yf1+5nyXHdWdAgMBAAGjQjBA
        MA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBR7W0XP
        r87Lev0xkhpqtvNG61dIUDANBgkqhkiG9w0BAQUFAAOCAQEAeRHAS7ORtvzw6WfU
        DW5FvlXok9LOAz/t2iWwHVfLHjp2oEzsUHboZHIMpKnxuIvW1oeEuzLlQRHAd9mz
        YJ3rG9XRbkREqaYB7FViHXe4XI5ISXycO1cRrK1zN44veFyQaEfZYGDm/Ac9IiAX
        xPcW6cTYcvnIc3zfFi8VqT79aie2oetaupgf1eNNZAqdE8hhuvU5HIe6uL17In/2
        /qxAeeWsEG89jxt5dovEN7MhGITlNgDrYyCZuen+MwS7QcjBAvlEYyCegc5C09Y/
        LHbTY5xZ3Y+m4Q6gLkH3LpVHz7z9M/P2C2F+fpErgUfCJzDupxBdN49cOSvkBPB7
        jVaMaA==
        -----END CERTIFICATE-----
      ''
      ''
        -----BEGIN CERTIFICATE-----
        MIIEKjCCAxKgAwIBAgIQYAGXt0an6rS0mtZLL/eQ+zANBgkqhkiG9w0BAQsFADCB
        rjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDHRoYXd0ZSwgSW5jLjEoMCYGA1UECxMf
        Q2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjE4MDYGA1UECxMvKGMpIDIw
        MDggdGhhd3RlLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxJDAiBgNV
        BAMTG3RoYXd0ZSBQcmltYXJ5IFJvb3QgQ0EgLSBHMzAeFw0wODA0MDIwMDAwMDBa
        Fw0zNzEyMDEyMzU5NTlaMIGuMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMdGhhd3Rl
        LCBJbmMuMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
        MTgwNgYDVQQLEy8oYykgMjAwOCB0aGF3dGUsIEluYy4gLSBGb3IgYXV0aG9yaXpl
        ZCB1c2Ugb25seTEkMCIGA1UEAxMbdGhhd3RlIFByaW1hcnkgUm9vdCBDQSAtIEcz
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsr8nLPvb2FvdeHsbnndm
        gcs+vHyu86YnmjSjaDFxODNi5PNxZnmxqWWjpYvVj2AtP0LMqmsywCPLLEHd5N/8
        YZzic7IilRFDGF/Eth9XbAoFWCLINkw6fKXRz4aviKdEAhN0cXMKQlkC+BsUa0Lf
        b1+6a4KinVvnSr0eAXLbS3ToO39/fR8EtCab4LRarEc9VbjXsCZSKAExQGbY2SS9
        9irY7CFJXJv2eul/VTV+lmuNk5Mny5K76qxAwJ/C+IDPXfRa3M50hqY+bAtTyr2S
        zhkGcuYMXDhpxwTWvGzOW/b3aJzcJRVIiKHpqfiYnODz1TEoYRFsZ5aNOZnLwkUk
        OQIDAQABo0IwQDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNV
        HQ4EFgQUrWyqlGCc7eT/+j4KdCtjA/e2Wb8wDQYJKoZIhvcNAQELBQADggEBABpA
        2JVlrAmSicY59BDlqQ5mU1143vokkbvnRFHfxhY0Cu9qRFHqKweKA3rD6z8KLFIW
        oCtDuSWQP3CpMyVtRRooOyfPqsMpQhvfO0zAMzRbQYi/aytlryjvsvXDqmbOe1bu
        t8jLZ8HJnBoYuMTDSQPxYA5QzUbF83d597YV4Djbxy8ooAw/dyZ02SUS2jHaGh7c
        KUGRIjxpp7sC8rZcJwOJ9Abqm+RyguOhCcHpABnTPtRwa7pxpqpYrvS76Wy274fM
        m7v/OeZWYdMKp8RcTGB7BXcmer/YB1IsYvdwY9k5vG8cwnncdimvzsUsZAReiDZu
        MdRAGmI0Nj81Aa6sY6A=
        -----END CERTIFICATE-----
      ''
      ''
        -----BEGIN CERTIFICATE-----
        MIIFjzCCBTSgAwIBAgIQLk/0vCQf0ZZ/H92kT/tl/jALBglghkgBZQMEAwIwga4x
        CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwx0aGF3dGUsIEluYy4xKDAmBgNVBAsTH0Nl
        cnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xODA2BgNVBAsTLyhjKSAyMDEy
        IHRoYXd0ZSwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MSQwIgYDVQQD
        Ext0aGF3dGUgUHJpbWFyeSBSb290IENBIC0gRzQwHhcNMTIxMDE1MDAwMDAwWhcN
        MzcxMjAxMjM1OTU5WjCBrjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDHRoYXd0ZSwg
        SW5jLjEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjE4
        MDYGA1UECxMvKGMpIDIwMTIgdGhhd3RlLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQg
        dXNlIG9ubHkxJDAiBgNVBAMTG3RoYXd0ZSBQcmltYXJ5IFJvb3QgQ0EgLSBHNDCC
        A0YwggI5BgcqhkjOOAQBMIICLAKCAQEAuKVG7qscYrwa+gRUVIUUaIbYo3g8dU85
        I2dmd62jZc6E4M7CnLmimI1lYeQ8QhGJvNGhvIZQoK62KtiKAmR7CZ8FeDPujvMx
        gh/NiWmiTXHKUABzR9rTX+GFXGIzKpwLgYEH+aX4T8DGOJbT1NQjvtrUD+OjUv/t
        MlC7Sf+/RGlQe9vanTKB1wenDEKaO/9QgleE29AtpdzuGzTVI2VwL1kNA8Ez9XdE
        r6WTYOI+CX/z9O/itvXTThpPbHoXN8lbOEKHSnINQeURhU4dfcTClLj01T8j47LO
        yg7WxlpRWGNjRh/FAeU6ETZvd4UE1Zq7Uq6XVnxgc3p47vkpXdLVLQIhALPolWFX
        lPUCYH74I/jxM3/Zzuw9PVr8b3okbIFwNq+hAoIBABEgze+P0RWy3WZy1w6reNOI
        0n5QtwiwvCnDGt/HPO7NeB0qhyLXl9NwVdj1OmN9jn3mfATGrpuJZOBQkoAfTp+Y
        rz6SN9nS9ityIvDpZu7+XEp8qU95xsJ69rS7lRle2qPT5iolHGKA4czbwOLephg8
        GGIoIorQcxgUVRHXFhvswgcAxHv5fG3vX+YTnycrvPsVt+Uv5vteIUyBD5J6ybOg
        xEEgtSeBKkrEDHTTQU/8ZxJR1Wd3CmYJXICvbG7GnbX5BSVSoPqC58KBqqjY9j+F
        IyAV/Vyi1VqVr+qxfzrwXqxS0e6eZXIe4/ztknFOwrfyUBLnsQkfG7c8EWvcMsAD
        ggEFAAKCAQBTC/9/4vZWeiazdA/ujWrT/ZypqHFDIAXaIe/l8yMhZJnAxkJGlsK1
        aGwMtcVCzrxrRQXMocvNntNTv5SIA2yg5HkHO1z/2mb360X4u374cVmNbZN6vKi2
        RwIngV/b4SKpT8pCwUXOOO9wHZYQJi/aHXGBwkkrHLknS9RvEXaHd+NGCcTc3MRp
        ANpGl5ri4FQ0aDdw8OT3ITHvpUxfmv5z7z6U3ZMwnio7ZCVFj0YBD900oiHhlpwY
        LbbJiVIWvze+hxsIBOxVCJHf7vr0FqN+8BJK4SHKHgAI/IHOz3vM6fXAevDj/F9F
        7IQYh94T6mGueqYylB9ib/diNcqfO7Nqo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYD
        VR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUx2eJZCLxnbHzi4Omwg6Zk1F265YwCwYJ
        YIZIAWUDBAMCA0gAMEUCIQCu5jrSlbF2eM49USoLQ36j8pTHZKIvLvWARxfM6dvr
        cwIgXKaxL+n4xluL6+8J3bYiE/wb5wUoC8hlSfg82gzLMd8=
        -----END CERTIFICATE-----
      ''
      ''
        -----BEGIN CERTIFICATE-----
        MIIE0zCCA7ugAwIBAgIQGNrRniZ96LtKIVjNzGs7SjANBgkqhkiG9w0BAQUFADCB
        yjELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQL
        ExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAwNiBWZXJp
        U2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQDEzxW
        ZXJpU2lnbiBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0
        aG9yaXR5IC0gRzUwHhcNMDYxMTA4MDAwMDAwWhcNMzYwNzE2MjM1OTU5WjCByjEL
        MAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZW
        ZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAwNiBWZXJpU2ln
        biwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQDEzxWZXJp
        U2lnbiBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0aG9y
        aXR5IC0gRzUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvJAgIKXo1
        nmAMqudLO07cfLw8RRy7K+D+KQL5VwijZIUVJ/XxrcgxiV0i6CqqpkKzj/i5Vbex
        t0uz/o9+B1fs70PbZmIVYc9gDaTY3vjgw2IIPVQT60nKWVSFJuUrjxuf6/WhkcIz
        SdhDY2pSS9KP6HBRTdGJaXvHcPaz3BJ023tdS1bTlr8Vd6Gw9KIl8q8ckmcY5fQG
        BO+QueQA5N06tRn/Arr0PO7gi+s3i+z016zy9vA9r911kTMZHRxAy3QkGSGT2RT+
        rCpSx4/VBEnkjWNHiDxpg8v+R70rfk/Fla4OndTRQ8Bnc+MUCH7lP59zuDMKz10/
        NIeWiu5T6CUVAgMBAAGjgbIwga8wDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8E
        BAMCAQYwbQYIKwYBBQUHAQwEYTBfoV2gWzBZMFcwVRYJaW1hZ2UvZ2lmMCEwHzAH
        BgUrDgMCGgQUj+XTGoasjY5rw8+AatRIGCx7GS4wJRYjaHR0cDovL2xvZ28udmVy
        aXNpZ24uY29tL3ZzbG9nby5naWYwHQYDVR0OBBYEFH/TZafC3ey78DAJ80M5+gKv
        MzEzMA0GCSqGSIb3DQEBBQUAA4IBAQCTJEowX2LP2BqYLz3q3JktvXf2pXkiOOzE
        p6B4Eq1iDkVwZMXnl2YtmAl+X6/WzChl8gGqCBpH3vn5fJJaCGkgDdk+bW48DW7Y
        5gaRQBi5+MHt39tBquCWIMnNZBU4gcmU7qKEKQsTb47bDN0lAtukixlE0kF6BWlK
        WE9gyn6CagsCqiUXObXbf+eEZSqVir2G3l6BFoMtEMze/aiCKm0oHw0LxOXnGiYZ
        4fQRbxC1lfznQgUy286dUV4otp6F01vvpX1FQHKOtw5rDgb7MzVIcbidJ4vEZV8N
        hnacRHr2lVz2XTIIM6RUthg/aFzyQkqFOFSDX9HoLPKsEdao7WNq
        -----END CERTIFICATE-----
      ''
    ];
  };

  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    #  extraConfig = "load-module module-loopback latency_msec=1";
    };
    opengl = {
      enable = true;
      package = pkgs.mesa.drivers;
      package32 = pkgs.pkgsi686Linux.mesa.drivers;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    ratbagd.enable = true;
  };
  # Enable the X11 windowing system.
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    enable = true;
    autorun = true;

    layout = "br";
  #  libinput.enable = true;

  #  windowManager.xmonad = {
  #    enable = true;
  #    enableContribAndExtras = true;
  #    extraPackages = haskellPackages: [
  #    ];
  #  };
    displayManager = {
  #    gdm = {
  #      enable = true;
  #      autoSuspend = false;
  #    };
  #    defaultSession = "none+xmonad";
  #    startx.enable = true;
  #    job.execCmd = "";
  #    sessionCommands = ''
  #      ${pkgs.xorg.xrdb}/bin/xrdb -merge ~/.Xresources
  #    '';
    };
    desktopManager = {
      gnome3.enable = true;
    };
  };

  security.sudo.configFile = ''
    root ALL=(ALL:ALL) ALL
    %wheel ALL=(ALL) ALL
    %docker ALL=(ALL) NOPASSWD: /etc/docker
  '';

  users.users.patrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; let
      python-custom = python-packages: with python-packages; [ pillow flask ];
      python-with-packages = python3.withPackages python-custom;

      haskellDeps = ps: with ps; with haskellPackages; [ ghc cabal-install stack zlib ]; # haskell-language-server implicit-hie alex happy ];
      haskellEnv  = haskellPackages.ghcWithPackages haskellDeps;

      i686-packages = with pkgsi686Linux; [ gnutls openldap libgpgerror libxml2 alsaPlugins SDL2 freetype dbus libgcrypt ];

      vimThings = [ nodejs (vimHugeX.customize {
        name = "vim";
        vimrcConfig = {
          packages.myplugins = with pkgs.vimPlugins; {
            start = [ coc-nvim vim-airline vim-airline-themes fugitive ];
            opt = [];
          };
          customRC = ''
            set backspace=indent,eol,start

            set tabstop=2
            set shiftwidth=2
            set expandtab
            set number
            set mouse=a
            set nowrap

            " set encoding=utf-8
            " set hidden
            " set nobackup
            " set nowritebackup
            " set cmdheight=2
            " set updatetime=300
            " set shortmess+=c
            " set signcolumn=number

            " inoremap <silent><expr> <TAB>
            "   \ pumvisible() ? "\<C-n>" :
            "   \ <SID>check_back_space() ? "\<TAB>" :
            "   \ coc#refresh()
            " inoremap <expr><S-TAB> pumvisibile() ? "\<C-p>" : "\<C-h>"

            " function! s:check_back_space() abort
            "   let col = col('.') - 1
            "   return !col || getline('.')[col - 1] =~# '\s'
            " endfunction

            " inoremap <silent><expr> <c-@> coc#refresh()

            " nmap <silent> [g <Plug>(coc-diagnostic-prev)
            " nmap <silent> ]g <Plug>(coc-diagnostic-next)

            " nmap <silent> gd <Plug>(coc-definition)
            " nmap <silent> gy <Plug>(coc-type-definition)
            " nmap <silent> gi <Plug>(coc-implementation)
            " nmap <silent> gr <Plug>(coc-references)

            " nnoremap <silent> K :call <SID>show_documentation()<CR>

            " function! s:show_documentation()
            "   if (index(['vim', 'help'], &filetype >= 0)
            "     execute 'h '.expand('<cword>')
            "   elseif (coc#rpc#ready())
            "     call CocActionAsync('doHover')
            "   else
            "     execute '!' . &keywordprg . " " . expand('<cword>')
            "   endif
            " endfunction

            " autocmd CursorHold * silent call CocActionAsync('highlight')

            " nmap <leader>rn <Plug>(coc-rename)

            " xmap <leader>f <Plug>(coc-format-selected)
            " nmap <leader>f <Plug>(coc-format-selected)

            let g:airline#extensions#coc#enabled = 1
            let g:airline#extensions#tabline#enabled = 1
            let g:airline_powerline_fonts = 1
          '';
        };
      })];
    in [
      wget curl htop unzip unrar p7zip cabextract killall git tree xorg.xev lsof
      haskellEnv icu ncurses kitty bind gcc lua binutils
      ffmpeg libratbag piper
    #  obs-studio obs-gstreamer
      pavucontrol gimp chromium appimage-run gnome3.dconf-editor audacity
      python-with-packages
      vscode gnumake powerline
      mesa vulkan-tools vulkan-loader vulkan-headers
      wineWowPackages.staging steam lutris discord spotify protontricks # libreoffice 
      (winetricks.overrideAttrs(old: {
        src = pkgs.fetchurl {
          # https://github.com/Winetricks/winetricks/releases
          url = "https://github.com/Winetricks/winetricks/releases/download/20210206/20210206.tar.gz";
          sha256 = "0rdfm1pw0vksyi842xcnn0x39fb8n01xzsq4f5bnys98idwj2m3h";
        };
      }))
    ]
    ++ i686-packages
    ++ vimThings;
  };

  users.users.default = {
    isNormalUser = true;
  };

  system = {
    stateVersion = "unstable";
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };

}

