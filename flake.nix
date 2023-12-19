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
  };

  outputs = inputs:
  let
    macbookSetup = import ./hosts/macos;
  in {
    darwinConfigurations.Matejas-MacBook-Pro = macbookSetup inputs;
  };
}
