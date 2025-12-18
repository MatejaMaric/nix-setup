
{nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, disko, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "discord"
        "winbox"
      ];
      permittedInsecurePackages = [
        # "olm-3.2.16"
        "electron-36.9.5" # used by RStudio
      ];
    };
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  specialArgs = {
    pkgs-unstable = import nixpkgs-unstable nixpkgsConfig;
  };
  modules = [
    disko.nixosModules.disko
    ../../modules/disko/thinkpad-t490.nix
    {
      _module.args.disks = [ "/dev/nvme0n1" ];
      _module.args.mainPool = "rpool";
    }

    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-t490

    home-manager.nixosModules.home-manager
    ./configuration.nix
  ];
}
