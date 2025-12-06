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
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # Wayland compositor and tools (Linux only)
    niri
    xwayland-satellite
    
    # Additional Wayland utilities you might want
    wl-clipboard
    grim        # Screenshot tool
    slurp       # Screen area selector
    swaylock    # Screen locker
  ];

  # Fonts that work everywhere
  fonts.fontconfig.enable = lib.mkIf pkgs.stdenv.isLinux true;
}
