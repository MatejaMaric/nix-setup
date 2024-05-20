{nixpkgs, matejasblog, yotaLaravel, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
    overlays = [
      matejasblog.overlays.default
      yotaLaravel.overlays.default
    ];
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  modules = [
    yotaLaravel.nixosModules.default
    ./configuration.nix
  ];
}
