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
          openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6VEjJvZtjgC8dft65Y35WfzfFk0LwzYyM32QZc4PbAAhel0zPjlPyNJ1Px5UizlJ/3uslt+qpnHF5Nt3qK5VS4LgbMhA+5WNX6A4LeptwUilOecOvsVqRVpIBfGI/JhxpKnB31M5r0LfmQPTfKTeLoECP275Ct3J/jq3QmOccZL3HhHrl0qDZ1e3uT1SoOnToN62dw9jEKPthfCC6QAwdSTj3p5ULRd0K/rdNIBVmqsvMgirGlIqUHI5TofwgEB4VjqG4gvo/rADcchFqT/VCMVzwGBhTNvGH7h+kjgmvmjBC/p9Bh3Gw2X0Utw+KHFtgdjSAkslfT4UHYBowoOv2cOKtoszqr59xImw5c/Ia/FeqUsnPylcZr+YFnNLZY0VDLPCkM6uNARLJRbvjzlfsqvuqWXoenXEjbELKcMt6S69nwh8kA9NJHsBL/eIXqycj5s9cQ1xpiHye34ivrWwQxOswtUHI6FOxdTqkxlfoORrUq8z1mCOsfinMbbEDbjk= mateja@laptop"
          ];
        };
      };
      environment.systemPackages = with pkgs; [
        tmux
        php83
        php83Packages.composer
        php83Extensions.mbstring
        php83Extensions.xml
        php83Extensions.bcmath
        gitolite
        opensmtpd
        dovecot
        rspamd
        redis
      ];
      services.openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
        settings.KbdInteractiveAuthentication = false;
        settings.PermitRootLogin = "no";
      };
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
