{nixpkgs, home-manager, ...}: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    system = "x86_64-linux";
    config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
      "discord"
    ];
  };
  modules = [
    ./configuration.nix
  ];
}
