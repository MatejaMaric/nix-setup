{darwin, nixpkgs, nixpkgs-unstable, home-manager, ...}:
let
  system = "aarch64-darwin";
  nixpkgsConfig = {
    inherit system;
  };
in darwin.lib.darwinSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  specialArgs = {
    pkgs-unstable = import nixpkgs-unstable nixpkgsConfig;
  };
  modules = [
    ../../modules/darwin
    home-manager.darwinModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.mateja.imports = [ ../../modules/home-manager ];
      };
    }
  ];
}
