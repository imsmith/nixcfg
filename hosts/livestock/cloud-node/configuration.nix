configuration.nix

{
  description = "Net Node NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.net-node = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto-update from Git
  systemd.services.nixos-auto-update = {
    description = "Auto-update NixOS from Git";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      cd /etc/nixos
      ${pkgs.git}/bin/git pull origin main
      ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /etc/nixos#net-node
    '';
  };

  systemd.timers.nixos-auto-update = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "1h";
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    dnsutils
  ];

  # User configuration
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGEnFnPz+ibD5TYf5ahL/UM7062pQ2FFqtcGYpWOY1KO imsmith@radon"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # Docker
  virtualisation.docker.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # DDNS Service
  systemd.services.ddns-update = {
    description = "DDNS Update";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /usr/local/bin/ddns-update";
    };
  };

  systemd.timers.ddns-update = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "15min";
    };
  };

  system.stateVersion = "24.05";
}