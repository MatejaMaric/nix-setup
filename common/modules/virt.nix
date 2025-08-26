{ config, pkgs, ... }:
{

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;
  # Enable virt-manager (besides adding the virt-manager package, it also sets appropriate dconf parametars)
  programs.virt-manager.enable = true;

  users = {
    # Add user to libvirtd group
    users.mateja.extraGroups = [
      "libvirtd"
      "docker"
    ];
  };

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    # virt-manager # already added
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    # gnome.adwaita-icon-theme # needed only if you don't have gnome installed
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
    docker = {
      enable = true;
    };
  };

  services.spice-vdagentd.enable = true;
}
