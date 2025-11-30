{
    description = "SQLite database management";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    outputs = { self, nixpkgs }: {
      nixosConfigurations.sqlite = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {
            services.sqlite.enable = true;
            services.sqlite.databases = {
              mydb = {
                path = "/var/lib/sqlite/mydb.sqlite";
                user = "sqlite";
                group = "sqlite";
              };
            };
          })
        ];
      };
    };
}