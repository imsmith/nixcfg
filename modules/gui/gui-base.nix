{ config, pkgs, lib, ... }:

{
  # Cross-platform GUI applications
  home.packages = with pkgs; [
    # Browsers (if managing via nix)
    #firefox
    
    # Development
    # vscodium
    #wireshark

    # Communication
    #slack
    #discord
    #signal-desktop

    # Publishing
    pandoc
    texlive.combined.scheme-full
  ];

  # Fonts that work everywhere
  fonts.fontconfig.enable = lib.mkIf pkgs.stdenv.isLinux true;
}
