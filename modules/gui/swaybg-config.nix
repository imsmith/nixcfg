{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  # Install swaybg
  home.packages = with pkgs; [
    swaybg
  ];

  # Create a systemd service to run swaybg
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      # Set your wallpaper here - options:
      # -i <path>: path to image
      # -c <color>: solid color (e.g., #1e1e2e)
      # -m <mode>: fill, fit, stretch, center, tile
      ExecStart = "${pkgs.swaybg}/bin/swaybg -c '#1e1e2e'";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Example: To use an image instead, uncomment and modify:
  # systemd.user.services.swaybg.Service.ExecStart = lib.mkForce 
  #   "${pkgs.swaybg}/bin/swaybg -i ~/Pictures/wallpaper.jpg -m fill";
}
