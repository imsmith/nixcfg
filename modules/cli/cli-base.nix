{ config, pkgs, lib, ... }:

{
  # Core CLI tools for local development
  home.packages = with pkgs; [
    # File navigation & search
    fd
    ripgrep
    fzf
    
    # Shell enhancements
    starship
    atuin
    zellij
    
    # File manager
    yazi
    
    # Basic utilities
    curl
    wget
    jq
    tree
    htop
    git
    just
    gnumake
  ];

  # Direnv for per-project environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    # Add any zsh config here
  };
}
