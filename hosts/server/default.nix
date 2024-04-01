{nixpkgs, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  modules = [
    ./configuration.nix
  ];
}
