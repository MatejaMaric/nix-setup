{darwin, nixpkgs, home-manager, ...}: darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    system = "aarch64-darwin";
  };
  modules = [
    ../../modules/darwin
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.mateja.imports = [ ../../modules/home-manager ];
      };
    }
  ];
}
