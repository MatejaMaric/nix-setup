{
  description = "my first flake system config";
  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:/nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:/lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: {
    darwinConfigurations.Matejas-MacBook-Pro = inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import inputs.nixpkgs {
        system = "aarch64-darwin";
      };
      modules = [
        ./modules/darwin
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.mateja.imports = [ ./modules/home-manager ];
          };
        }
      ];
    };
  };
}
