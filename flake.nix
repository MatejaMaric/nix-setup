{
  description = "Nix Flake for configuring systems I use";

  inputs = {
    nixpkgs.url = "github:/NixOS/nixpkgs/nixos-24.11";
    nixpkgs-r2311.url = "github:/NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:/NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-darwin.url = "github:/NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-darwin-r2311.url = "github:/NixOS/nixpkgs/nixpkgs-23.11-darwin";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    darwin.url = "github:/lnl7/nix-darwin/nix-darwin-24.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:/nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    matejasblog.url = "github:/MatejaMaric/blog";
    matejasblog.inputs.nixpkgs.follows = "nixpkgs";

    yotaLaravel.url = "github:/MatejaMaric/yota-laravel";
    yotaLaravel.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
  let
    macbookSetup = import ./hosts/macos;
    hpLaptopSetup = import ./hosts/hp-laptop;
    thinkpadT490Setup = import ./hosts/thinkpad-t490;
    serverSetup = import ./hosts/server;
  in {
    darwinConfigurations.Matejas-MacBook-Pro = macbookSetup {
      inherit (inputs) darwin nixpkgs-unstable home-manager;
      nixpkgs = inputs.nixpkgs-darwin;
      nixpkgs-r2311 = inputs.nixpkgs-darwin-r2311;
    };
    nixosConfigurations.hp-laptop = hpLaptopSetup inputs;
    nixosConfigurations.thinkpad-t490 = thinkpadT490Setup inputs;
    nixosConfigurations.server = serverSetup inputs;
  };
}
