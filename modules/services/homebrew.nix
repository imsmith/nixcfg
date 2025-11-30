{ config, pkgs, lib, ... }:

{
  # macOS system-level configuration
  # This is a nix-darwin module (not home-manager)
  
  homebrew = {
    enable = true;
    
    casks = [
      # Terminal
      "ghostty"
      
      # Development
      "visual-studio-code"
      
      # Communication
      "slack"
      "firefox"
      #"microsoft-teams" # Microsoft Teams
      "obs"
      
      # Productivity
      "raycast"
      "obsidian"
      
      # Window Management
      "nikitabobko/tap/aerospace"
      # "FelixKratz/tap/sketchybar"
      
      # Fonts
      # fonts now installed in fonts.nix
      #"font-victor-mono-nerd-font"
    ];
    
    # Optional: auto-update homebrew
    # onActivation.autoUpdate = true;
    # onActivation.cleanup = "zap";  # Remove unlisted casks
  };
}
