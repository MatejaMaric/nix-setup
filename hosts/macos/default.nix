{darwin, nixpkgs, nixpkgs-unstable, home-manager, ...}:
let
  system = "aarch64-darwin";
  nixpkgsConfig = {
    inherit system;
    overlays = [(final: prev: {
      lunarvim = prev.lunarvim.overrideAttrs (finalAttrs: previousAttrs: {
        version = "latest";
        src = prev.fetchFromGitHub {
          owner = "LunarVim";
          repo = "LunarVim";
          rev = "85ccca97acfea9a465e354e18bb2f6109ba417f8";
          hash = "sha256-lFX9vmNwbpd4dPpILS4B6Qea5OtqUd7ecaRLEzlkK3g=";
        };
      });
    })];
  };
in darwin.lib.darwinSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  specialArgs = {
    pkgs-unstable = import nixpkgs-unstable nixpkgsConfig;
  };
  modules = [
    home-manager.darwinModules.home-manager
    ./configuration.nix
  ];
}
