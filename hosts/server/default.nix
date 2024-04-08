{nixpkgs, matejasblog, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
    overlays = [ matejasblog.overlays.default ];
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  modules = [
    ./configuration.nix
  ];
}
