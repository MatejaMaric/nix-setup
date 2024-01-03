{
  description = "my first flake system config";

  inputs = {
    nixpkgs = {
      url = "github:/nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:/nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:/lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
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
