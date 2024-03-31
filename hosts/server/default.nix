{nixpkgs, ...}:
let
  system = "x86_64-linux";
  nixpkgsConfig = {
    inherit system;
  };
in nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs nixpkgsConfig;
  modules = [
    { config, pkgs, ... }: {
      imports = [
        # ./hardware-configuration.nix
      ];
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      networking.hostName = "server";
      time.timeZone = "Europe/Frankfurt";
      i18n.defaultLocale = "en_US.UTF-8";
      nix.settings.experimental-features = ["nix-command" "flakes"];
      users = {
        users.mateja = {
          isNormalUser = true;
          description = "Mateja";
          extraGroups = [ "wheel" ];
        };
      };
      environment.systemPackages = with pkgs; [
        tmux
      ];
      services.openssh.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      networking.firewall.allowedTCPPorts = [ 50000 80 443 ];
      system.stateVersion = "23.11"; # Don't touch this
    }
  ];
}
