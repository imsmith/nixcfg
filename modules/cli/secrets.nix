{ config, pkgs, lib, ... }:

{
  # Secret management tools
  home.packages = with pkgs; [
    age
    gnupg
    pass
    # sops  # if you use sops-nix
    vault
  ];

  # GPG configuration
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableSshSupport = true;
  };
}
