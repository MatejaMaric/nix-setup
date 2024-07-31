{
  description = "Nix Flake for configuring systems I use";

  inputs = {
    nixpkgs.url = "github:/NixOS/nixpkgs/nixos-24.05";
    nixpkgs-r2311.url = "github:/NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:/NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:/NixOS/nixpkgs/nixpkgs-24.05-darwin";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:/nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:/lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    matejasblog.url = "github:/MatejaMaric/blog";
    matejasblog.inputs.nixpkgs.follows = "nixpkgs";

    yotaLaravel.url = "github:/MatejaMaric/yota-laravel";
    yotaLaravel.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
  let
    macbookSetup = import ./hosts/macos;
    hpLaptopSetup = import ./hosts/hp-laptop;
    serverSetup = import ./hosts/server;
  in {
    darwinConfigurations.Matejas-MacBook-Pro = macbookSetup inputs;
    nixosConfigurations.hp-laptop = hpLaptopSetup inputs;
    nixosConfigurations.server = serverSetup inputs;
  };
}
