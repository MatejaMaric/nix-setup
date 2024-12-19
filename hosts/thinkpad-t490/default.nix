
{nixpkgs, nixpkgs-r2311, nixpkgs-unstable, home-manager, nixos-hardware, disko, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "discord"
      ];
      permittedInsecurePackages = [
        # "olm-3.2.16"
      ];
    };
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  specialArgs = {
    pkgs-r2311 = import nixpkgs-r2311 nixpkgsConfig;
    pkgs-unstable = import nixpkgs-unstable nixpkgsConfig;
  };
  modules = [
    disko.nixosModules.disko
    ../../modules/disko/hp-laptop.nix
    {
      _module.args.disks = [ "/dev/vda" ];
      _module.args.mainPool = "rpool";
    }
    home-manager.nixosModules.home-manager
    ./configuration.nix
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];
}
