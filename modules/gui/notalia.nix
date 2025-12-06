{
  description = "NixOS configuration with Noctalia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";  # Use same quickshell version
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.awesomebox = nixpkgs.lib.nixosSystem {
      modules = [
        # ... other modules
        ./noctalia.nix
      ];
    };
  };
}