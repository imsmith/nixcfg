{ config, pkgs, lib, ... }:

{
  # CLI tools for working with remote systems
  home.packages = with pkgs; [
    # SSH & networking
    openssh
    rsync
    nmap
    nc
    #tailscale
    
    # Remote system management
    tmux
    mosh  # mobile shell
    
    # Optional: cloud CLI tools
    awscli2
    google-cloud-sdk
    azure-cli
    gh
  ];

  programs.ssh = {
    enable = true;
    # Add SSH config here if needed
  };
}
