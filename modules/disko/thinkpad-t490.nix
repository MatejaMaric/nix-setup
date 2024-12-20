{ disks ? [ "/dev/nvme0n1" ], mainPool ? "rpool", ... }: {
  disko.devices = {

    disk.main = {
      type = "disk";
      device = builtins.elemAt disks 0;
      content.type = "gpt";
      content.partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        zfs = {
          size = "100%";
          content = {
            type = "zfs";
            pool = mainPool;
          };
        };
      };
    };

    zpool.${mainPool} = {
      type = "zpool";
      # mode = "mirror";
      # Workaround: cannot import 'zroot': I/O error in disko tests
      options.cachefile = "none";
      rootFsOptions = {
        compression = "zstd";
      };
      datasets = {
        "enc" = {
          type = "zfs_fs";
          options = {
            mountpoint = "none";
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
            keylocation = "file:///tmp/secret.key";
          };
          # use this to read the key during boot
          postCreateHook = ''
            zfs set keylocation="prompt" "${mainPool}/enc";
          '';
        };
        "enc/root" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/";
        };
        "enc/nix" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/nix";
        };
        "enc/var" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/var";
        };
        "enc/home" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/home";
        };
      };
    };

  };
}
