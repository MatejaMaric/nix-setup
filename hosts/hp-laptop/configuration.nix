# See available options: man 5 configuration.nix
# Open NixOS manual: nixos-help
{ config, pkgs, pkgs-r2311, pkgs-unstable, ... }:
let
  defaultPkgs = import ../../common/packages;
in {
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "i915" ];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [ "i915.force_probe=9a49" ];
    supportedFilesystems = [ "zfs" ];
    # zfs.forceImportRoot = false;
    zfs.extraPools = [ "rpool" ];
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  networking = {
    hostName = "hp-laptop";
    hostId = "99d0e226";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [];
    };
    hosts = {
      # "127.0.0.1" = ["matejamaric.com" "mail.matejamaric.com" "yota.yu1srs.org.rs"];
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
      extraGroups = [ "networkmanager" "wheel" ];
    };
    extraGroups.vboxusers.members = [ "mateja" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mateja.imports = [ ../../modules/home-manager ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CommitMono" ]; })
  ];

  environment = {
    variables = {
      VDPAU_DRIVER = "va_gl";
    };
    sessionVariables = {
      EDITOR = "nvim";
      XCURSOR_THEME = "Adwaita";
      VDPAU_DRIVER = "va_gl";
    };
    systemPackages = with pkgs; [
      darktable
      discord
      element-desktop
      firefox
      libreoffice
      nheko
      pinentry
      texliveFull
      thunderbird
      vesktop
      wl-clipboard
    ] ++ (defaultPkgs { inherit pkgs pkgs-r2311 pkgs-unstable; });
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.virtualbox.host.enable = true;

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
