{ config, pkgs, ... }:

{
  security.sudo.configFile = ''
    root ALL=(ALL:ALL) ALL
    %wheel ALL=(ALL) ALL
  '';

  programs = {
    adb.enable                = false;
    vim.defaultEditor         = true;
    bash.interactiveShellInit = ''
      powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
      POWERLINE_BASH_SELECT=1
      . /etc/profiles/per-user/ptkato/share/bash/powerline.sh
    '';
  };

  users.mutableUsers = false;
  users.users.ptkato = {
    isNormalUser   = true;
    hashedPassword = "$6$fEtvYS02Dj3m980u$CH86PFq2/NqN3kvz0tfTOQmy8ZeslK71EeES3YCPSlUQaj9sQjA1eUqfUFhMo0eXHQUeg457q5cIv3dee1PnA0";
    extraGroups    = [ "wheel" "networkmanager" "docker" "adbusers" "libvirtd"];

    packages = with pkgs; [
      firefox chromium
      discord element-desktop
      signal-desktop zoom-us
      transmission-gtk

      steam lutris spotify
      steam-run obs-studio
      wineWowPackages.staging
      protontricks winetricks

      gimp libreoffice
      ffmpeg libratbag piper
      pavucontrol paprefs audacity
      kitty python39Packages.powerline via
      gnome-latex mendeley
      postgresql ventoy-bin
      docker zlib rar fuse

      haskell-language-server
      haskellPackages.ghcup
      haskellPackages.cabal2nix
      haskellPackages.happy
      haskellPackages.alex

    ] ++ [ (vscode-with-extensions.override {
      vscodeExtensions = [
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.justusadam.language-haskell
        vscode-extensions.haskell.haskell
        vscode-extensions.eamodio.gitlens
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
