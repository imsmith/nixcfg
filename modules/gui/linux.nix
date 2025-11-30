{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # Linux-specific GUI applications
  home.packages = with pkgs; [
    # Linux desktop apps
    # kitty
    # alacritty
  ];

  # X11/Wayland settings
  xsession.enable = lib.mkDefault false;  # Set to true if using X11
  
  # Desktop environment integration
  # services.dunst.enable = true;  # notifications
}
