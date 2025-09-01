{ config, pkgs, nixos-unstable, nixpkgs-unstable, nixpkgs-pinned, ... }:

{
  security.sudo.configFile = ''
    root ALL=(ALL:ALL) ALL
    %wheel ALL=(ALL) ALL
  '';

  programs = {
    adb.enable                = false;
    vim.enable                = true;
    vim.defaultEditor         = true;
    bash.interactiveShellInit = ''
      powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
      POWERLINE_BASH_SELECT=1
      . /etc/profiles/per-user/ptkato/share/bash/powerline.sh
    '';

    gamescope.capSysNice = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          nixpkgs-pinned.gamescope-wsi
          libkrb5 keyutils
        ];
      };
    };
  };


  users.mutableUsers = false;
  users.users.ptkato = {
    isNormalUser   = true;
    hashedPassword = "$6$fEtvYS02Dj3m980u$CH86PFq2/NqN3kvz0tfTOQmy8ZeslK71EeES3YCPSlUQaj9sQjA1eUqfUFhMo0eXHQUeg457q5cIv3dee1PnA0";
    extraGroups    = [ "wheel" "networkmanager" "docker" "adbusers" "libvirtd"];

    packages = with pkgs; [
      firefox chromium
      (discord.override { withVencord = true; })
      arrpc nixpkgs-pinned.element-desktop
      signal-desktop zoom-us
      transmission_4-qt # transmission_4-gtk

      # (let hackedPkgs = pkgs.extend (final: prev: { buildFHSEnv = args: prev.buildFHSEnv (args // { extraBwrapArgs = (args.extraBwrapArgs or []) ++ [ "--cap-add ALL" ]; }); }); in hackedPkgs.lutris)
      lutris spotify
      nexusmods-app-unfree
      prismlauncher
      steam-run obs-studio
      wineWowPackages.staging
      protontricks winetricks
      streamlink-twitch-gui-bin
      streamlink chatterino2

      gimp libreoffice
      ffmpeg libratbag piper
      vlc audacity
      kitty powerline via
      mendeley # gnome-latex
      postgresql # ventoy-full
      docker zlib rar fuse

      binutils gcc
      lmstudio

      haskell-language-server
      #haskellPackages.ghcup
      haskellPackages.cabal-install
      haskell.compiler.ghc8107Binary
      haskellPackages.cabal2nix
      haskellPackages.happy
      haskellPackages.alex
      haskellPackages.stack
      #haskellPackages.hsx
      ihp-new

      rustc cargo

    ] ++ [ (vscode-with-extensions.override {
      vscodeExtensions = [
        #vscode-extensions.ms-dotnettools.vscode-dotnet-runtime
        #vscode-extensions.ms-dotnettools.csharp
        #vscode-extensions.ms-dotnettools.csdevkit
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.arrterian.nix-env-selector
        vscode-extensions.justusadam.language-haskell
        vscode-extensions.haskell.haskell
        vscode-extensions.eamodio.gitlens
        vscode-extensions.tomoki1207.pdf
      ];
    })] ++ [ nodejs (vimHugeX.customize {
      name        = "vim";
      vimrcConfig = {
        packages.myplugins.opt   = [];
        packages.myplugins.start = [
          vimPlugins.vim-airline
          vimPlugins.vim-airline-themes
          vimPlugins.vim-fugitive
        ];

        customRC = ''
          function! NoTrailing()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
          endfun

          autocmd BufWritePre * :call NoTrailing()
          set backspace=indent,eol,start

          set tabstop=2
          set shiftwidth=2
          set expandtab
          set number
          set mouse=a
          set nowrap
          syntax on

          let g:airline#extensions#coc#enabled = 1
          let g:airline#extensions#tabline#enabled = 1
          let g:airline_powerline_fonts = 1
        '';
      };
    })];
  };
}
