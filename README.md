## How to use:

### MacOS:

First build the Nix Flake:

```bash
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.Matejas-MacBook-Pro.system
```

Then use the produced result directory (symlink) to switch into the configuration for the first time:

```bash
./result/sw/bin/darwin-rebuild switch --flake ~/nix-setup
```

Every time you change something you can just use this command, just don't forget to stage or commit the changes with Git:

```bash
darwin-rebuild switch --flake ~/nix-setup/.#
```

### NixOS:

This command is all you need:

```bash
sudo nixos-rebuild switch --flake ~/nix-setup/.#
```

## How to update packages:

You can update the flake using this command, which is going to update the flake lock file:

```bash
nix flake update
```

After than you can update the system itself by switching into the flake with `nixos-rebuild switch` or `darwin-rebuild switch` depending on the platform you use.
