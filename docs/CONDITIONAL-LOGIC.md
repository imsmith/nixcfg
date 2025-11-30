# Conditional Logic in Nix

## Key Concepts

### 1. Platform Detection

```nix
pkgs.stdenv.isDarwin   # true on macOS
pkgs.stdenv.isLinux    # true on Linux
pkgs.system            # "aarch64-darwin", "x86_64-linux", etc.
```

### 2. Conditional Imports in flake.nix

```nix
imports = [
  ./always-loaded.nix
  
  # Only load on macOS
  (lib.mkIf pkgs.stdenv.isDarwin ./darwin-only.nix)
  
  # Only load on Linux
  (lib.mkIf pkgs.stdenv.isLinux ./linux-only.nix)
];
```

### 3. Conditional Config Within Modules

```nix
{ config, pkgs, lib, ... }:

{
  # Always included
  home.packages = with pkgs; [
    curl
  ];

  # Only on Linux
  services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
  };

  # Only on macOS
  targets.darwin = lib.mkIf pkgs.stdenv.isDarwin {
    # macOS-specific settings
  };
}
```

### 4. Conditional Packages

```nix
home.packages = with pkgs; [
  # Always
  git
  
  # Platform-specific
] ++ lib.optionals pkgs.stdenv.isDarwin [
  # macOS only
  darwin.trash
] ++ lib.optionals pkgs.stdenv.isLinux [
  # Linux only
  xclip
];
```

### 5. Custom Conditions

```nix
{ config, pkgs, lib, ... }:

let
  isWorkMachine = config.networking.hostName == "work-laptop";
  hasGpu = config.hardware.nvidia.enable or false;
in
{
  home.packages = lib.optionals isWorkMachine [
    slack
    zoom
  ];
}
```

## Your Current Structure

```text
nix-darwin-config/
├── flake.nix              # Main config, imports modules
└── modules/
    ├── cli/
    │   ├── local-base.nix  # Core CLI tools
    │   ├── remote.nix      # SSH, cloud tools
    │   └── secrets.nix     # age, gpg, pass
    ├── gui/
    │   ├── base.nix        # Cross-platform GUI
    │   ├── darwin.nix      # macOS-specific (conditionally loaded)
    │   └── linux.nix       # Linux-specific (conditionally loaded)
    └── fonts.nix           # Fonts for all platforms
```

## Adding a New Machine

### macOS Machine

```nix
darwinConfigurations."my-macbook" = darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    # ... darwin config ...
    home-manager.darwinModules.home-manager
    {
      home-manager.users.myuser = { pkgs, lib, ... }: {
        imports = [
          ./modules/cli/local-base.nix
          ./modules/fonts.nix
          # darwin.nix auto-loaded via mkIf
        ];
      };
    }
  ];
};
```

### Linux Machine

```nix
homeConfigurations."user@linux-box" = home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  modules = [
    ./modules/cli/local-base.nix
    ./modules/cli/remote.nix
    ./modules/gui/base.nix
    # linux.nix auto-loaded via mkIf
  ];
};
```

## Common Patterns

### Enable a feature only if another is enabled

```nix
programs.starship = lib.mkIf config.programs.zsh.enable {
  enable = true;
};
```

### Multiple conditions

```nix
services.something = lib.mkIf (pkgs.stdenv.isLinux && config.graphical.enable) {
  enable = true;
};
```

### Default values with overrides

```nix
programs.git = {
  enable = lib.mkDefault true;  # Can be overridden
  userName = "Your Name";       # Always set
};
```

## Testing Your Config

```bash
# See what will be installed
nix flake show

# Build without switching (test for errors)
darwin-rebuild build --flake .#ismit-lpt-mac

# Actually apply changes
darwin-rebuild switch --flake .#ismit-lpt-mac

# Check what's in your environment
nix profile list
```
