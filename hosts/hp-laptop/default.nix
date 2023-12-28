{nixpkgs, home-manager, ...}: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    system = "x86_64-linux";
  };
  modules = [
    ./configuration.nix
  ];
}
