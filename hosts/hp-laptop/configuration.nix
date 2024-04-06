# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:
let
  defaultPkgs = import ../../common/packages;
in {
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [ "i915.force_probe=9a49" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
  };

  networking = {
    hostName = "hp-laptop";
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
    displayManager.gdm.enable = true;
    displayManager.gdm.debug = true;
    desktopManager.gnome.enable = true;
    layout = "us";
    xkbVariant = "";
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.mateja = {
      isNormalUser = true;
      description = "Mateja";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    darktable
    discord
    firefox
    libreoffice
    pinentry
    texliveFull
    thunderbird
    wl-clipboard
  ] ++ (defaultPkgs pkgs pkgs-unstable);

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
