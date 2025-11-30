{ config, pkgs, lib, ... }:

{
  # Fonts for terminal and coding
  home.packages = with pkgs; [
    # Nerd Fonts - individual packages
    nerd-fonts.victor-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Enable font management
  fonts.fontconfig.enable = lib.mkIf pkgs.stdenv.isLinux true;
}