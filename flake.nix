{
  description = "my first flake system config";

  inputs = {
    nixpkgs = {
      url = "github:/NixOS/nixpkgs/nixos-23.11";
    };

    nixpkgs-unstable = {
      url = "github:/NixOS/nixpkgs/nixpkgs-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:/lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    macbookSetup = import ./hosts/macos;
    hpLaptopSetup = import ./hosts/hp-laptop;
  in {
    darwinConfigurations.Matejas-MacBook-Pro = macbookSetup inputs;
    nixosConfigurations.hp-laptop = hpLaptopSetup inputs;
  };
}
