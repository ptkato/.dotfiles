{ config, pkgs, ... }:

{
  fonts.enableDefaultPackages = true;
  # fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    roboto
    roboto-mono
    google-fonts
    powerline-fonts
  ];

  fonts.fontconfig.defaultFonts = {
    serif     = [ "Roboto Serif" ];
    sansSerif = [ "Roboto" ];
    monospace = [ "Roboto Mono for Powerline" "Roboto Mono" ];
  };

  console = {
    font = "Roboto Mono for Powerline";
  };
}
