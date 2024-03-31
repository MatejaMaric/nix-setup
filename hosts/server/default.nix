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
        php83
        php83Packages.composer
        php83Extensions.mbstring
        php83Extensions.xml
        php83Extensions.bcmath
      ];
      services.openssh.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      networking.firewall.allowedTCPPorts = [ 50000 80 443 25 587 993 ];
      services.nginx.enable = true;
      services.nginx.virtualHosts = {
        "matejamaric.com" = {
          enableACME = true;
          forceSSL = true;
          root = "/var/www/matejamaric.com";
        };
        "mail.matejamaric.com" = {
          enableACME = true;
          forceSSL = true;
          root = "/var/www/mail.matejamaric.com";
        };
        # "git.matejamaric.com" = { ... };
        "yota.yu1srs.org.rs" = {
          enableACME = true;
          forceSSL = true;
          root = "/var/www/yota.yu1srs.org.rs";
          locations."~ \\.php$".extraConfig = ''
            fastcgi_pass  unix:${config.services.phpfpm.pools.yotapool.socket};
            fastcgi_index index.php;
          '';
        };
      };
      security.acme = {
        acceptTerms = true;
        defaults.email = "matejamaricz@gmail.com";
      };
      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
      };
      services.phpfpm.pools.yotapool = {
        user = "nobody";
        settings = {
          "pm" = "dynamic";
          "listen.owner" = config.services.nginx.user;
          "pm.max_children" = 5;
          "pm.start_servers" = 2;
          "pm.min_spare_servers" = 1;
          "pm.max_spare_servers" = 3;
          "pm.max_requests" = 500;
        };
      };
      system.stateVersion = "23.11"; # Don't touch this
    }
  ];
}
