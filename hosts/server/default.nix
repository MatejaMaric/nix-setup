{nixpkgs, matejasblog, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
    overlays = [
      (final: prev: { inherit matejasblog; })
    ];
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  modules = [
    ./configuration.nix
  ];
}
