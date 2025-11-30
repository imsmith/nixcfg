{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  # macOS-specific GUI apps and settings
  # NOTE: This module is for home-manager settings
  # For homebrew casks, configure in modules/darwin/homebrew.nix
  
  home.packages = with pkgs; [
    # macOS-specific CLI tools that support GUI apps
  ];

  # macOS-specific home-manager settings
  targets.darwin = {
    # currentHostDefaults = ...
    # defaults = ...
  };
}
