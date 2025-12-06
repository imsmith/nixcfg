{ config, pkgs, lib, noctalia, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  # Install noctalia shell
  home.packages = [
    noctalia.packages.${pkgs.system}.default
  ];

  # Optional: Add noctalia configuration
  # You can add custom configuration for noctalia here
  # xdg.configFile."noctalia/config.conf".text = ''
  #   # Your noctalia configuration
  # '';
}
