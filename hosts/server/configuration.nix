{ config, pkgs, ... }: {
  system.stateVersion = "23.11"; # Don't touch this
  imports = [
    # ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "server";
  time.timeZone = "Europe/Frankfurt";
  i18n.defaultLocale = "en_US.UTF-8";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 50000 80 443 25 587 993 ];
  virtualisation.vmVariant.virtualisation = {
    graphics = false;
    forwardPorts = [
      { from = "host"; host.port = 50000; guest.port = 50000; }
      { from = "host"; host.port = 8080; guest.port = 80; }
    ];
  };
  users = {
    users.mateja = {
      isNormalUser = true;
      description = "Mateja";
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMZcuz2OPjpUGNPIE3/7UUwUIVBztmx478LFUahQaMm mail@matejamaric.com"
      ];
      initialHashedPassword = "$y$j9T$WwsIfZwdnLm84jjd9Q9wV1$fhDEn.TrvZVSaV6VNKpH0RWiPKAvaOhR.3oCkDlETO7";
    };
  };
  environment.systemPackages = with pkgs; [
    git
    tmux
    gitolite
    opensmtpd
    dovecot
    rspamd
    redis
    matejasblog
    yota-laravel
  ];
  services.openssh = {
    enable = true;
    ports = [ 50000 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.nginx.enable = true;
  services.nginx.virtualHosts = {
    localhost = {
      root = "${pkgs.matejasblog}/var/www/matejamaric.com/";
    };
    "matejamaric.com" = {
      enableACME = true;
      addSSL = true; # forceSSL = true;
      root = "${pkgs.matejasblog}/var/www/matejamaric.com/";
    };
    "mail.matejamaric.com" = {
      enableACME = true;
      addSSL = true; # forceSSL = true;
      root = "/var/www/mail.matejamaric.com";
    };
    "yota.yu1srs.org.rs" = {
      enableACME = true;
      addSSL = true; # forceSSL = true;
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "matejamaricz@gmail.com";
  };
  yotaLaravel.enable = true;
  yotaLaravel.domain = "yota.yu1srs.org.rs";
}
