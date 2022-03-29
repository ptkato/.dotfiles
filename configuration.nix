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
    /etc/nixos/obsidian
    #(./. + "./obsidian")
  ];

  nixpkgs.config.allowUnfree = true;
  nix.autoOptimiseStore      = true;
  nix.binaryCaches           = [ "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys  = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  nix.package                = pkgs.nixUnstable;
  nix.extraOptions           = "experimental-features = nix-command flakes";

  system = {
    stateVersion            = "21.05";
    autoUpgrade.enable      = true;
    autoUpgrade.allowReboot = false;
  };
}
