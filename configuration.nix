{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ./modules/filesystems.nix
    ./modules/boot.nix
    ./modules/users.nix
    ./modules/networking.nix
    ./modules/certificates.nix
    ./modules/environment.nix
    ./modules/fonts.nix
    #/etc/nixos/obsidian
    #(./. + "./obsidian")
  ];

  nixpkgs.config.allowUnfree = true;
  nix.package                = pkgs.nixUnstable;

  nix.settings = {
    substituters        = [ "https://nixcache.reflex-frp.org" ];
    trusted-public-keys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
    trusted-users       = [ "root" "@wheel" ];
    auto-optimise-store  = true;
  };

  nix.extraOptions           = ''
    experimental-features = nix-command flakes
    connect-timeout = 1
    download-attempts = 3
    fallback = true
  '';

  system = {
    stateVersion            = "21.05";
    autoUpgrade.enable      = true;
    autoUpgrade.allowReboot = false;
  };
}
