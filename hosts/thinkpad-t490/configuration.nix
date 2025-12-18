# See available options: man 5 configuration.nix
# Open NixOS manual: nixos-help
{ config, lib, pkgs, pkgs-r2311, pkgs-unstable, ... }:
let
  defaultPkgs = import ../../common/packages;
in {
  imports =
    [
      ../../common/modules/virt.nix
      ../../common/modules/sanoid.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "thinkpad-t490";
    hostId = "30aec81d";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 8080 ];
      allowedUDPPorts = [];
    };
    hosts = {
      # "127.0.0.1" = ["matejamaric.com" "mail.matejamaric.com" "yota.yu1srs.org.rs"];
    };
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
    # targets = {
    #   network-online.enable = lib.mkForce false;
    # };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.zfs.autoScrub = {
    enable = true;
    pools = [ "rpool" ];
    interval = "weekly";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      debug = true;
    };
    desktopManager.gnome = {
      enable = true;
      debug = true;
    };
    xkb = {
      layout = "us";
      variant = "";
    };
    # libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable support for SANE scanners
  hardware.sane.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.mateja = {
      isNormalUser = true;
      description = "Mateja";
      home = "/home/mateja";
      createHome = true;
      initialHashedPassword = "$y$j9T$7Y49sohFcg3U6XxNq3p8o.$mxii.YiAu0KBEH3oCtxuFoDUJIM.pA4uKy0TWmvP0B1";
      extraGroups = [ "networkmanager" "wheel" "scanner" ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mateja.imports = [ ../../modules/home-manager ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.commit-mono
    source-code-pro
  ];

  environment = {
    sessionVariables = {
      EDITOR = "nvim";
      XCURSOR_THEME = "Adwaita";
    };
    systemPackages = with pkgs; [
      # nheko
      (kodi.withPackages (kodiPkgs: with kodiPkgs; [ youtube ] ))
      (rWrapper.override { packages = with rPackages; [ tidyverse ]; })
      (rstudioWrapper.override{ packages = with rPackages; [ tidyverse  ]; })
      darktable
      discord
      element-desktop
      firefox
      fractal
      gnucash
      hdparm
      inkscape
      kdePackages.okular
      libreoffice
      pinentry
      sanoid
      texliveFull
      thunderbird
      ungoogled-chromium
      vesktop
      winbox4
      wl-clipboard
      xournalpp
    ] ++ (defaultPkgs { inherit pkgs pkgs-r2311 pkgs-unstable; });
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    # settings.PasswordAuthentication = false;
    # settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
