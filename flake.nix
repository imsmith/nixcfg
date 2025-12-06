{
  description = "macOS with nix-darwin + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Noctalia shell and dependencies
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, nixpkgs-unstable, quickshell, noctalia, ... }:
  let
    system = "aarch64-darwin";   # Apple Silicon
    pkgs = import nixpkgs { 
      inherit system; 
      config.allowUnfree = true;
    };
  in {
    darwinConfigurations."ismit-lpt-mac" = darwin.lib.darwinSystem {
      inherit system;
      
      specialArgs = { 
        inherit pkgs;
      };

      modules = [
        # Import darwin system modules
        ./modules/gui/darwin/homebrew.nix
        
        {
          # Required by nix-darwin
          system.stateVersion = 6;

          system.primaryUser = "iansmith";

          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          
          # Allow unfree packages
          nixpkgs.config.allowUnfree = true;

          environment.systemPackages = with pkgs; [
            git
            direnv
          ];

          programs.zsh.enable = true;

          users.users.iansmith = {
             home = "/Users/iansmith";
             # optional but usually nice:
             # shell = pkgs.zsh;
             # shell = pkgs.fish;
             # shell = pkgs.nushell;
          };

        }

        # Home Manager module for nix-darwin
        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit noctalia; };

          home-manager.users.iansmith = { pkgs, config, lib, ... }: {
            home.stateVersion = "25.05";
            home.homeDirectory = "/Users/iansmith";

            programs.home-manager.enable = true;

            # Import modular configurations
            imports = [
              ./modules/cli/cli-base.nix
              ./modules/cli/remote.nix
              ./modules/cli/secrets.nix
              ./modules/fonts.nix
              ./modules/gui/gui-base.nix
              ./modules/gui/darwin.nix
              ./modules/gui/linux.nix
              ./modules/gui/gui-work-tools.nix
              ./modules/gui/noctalia-shell.nix
              ./modules/gui/niri-config.nix
              ./modules/gui/waybar-config.nix
              ./modules/gui/swaybg-config.nix
            ];
          };
        }
      ];
    };
  };
}

