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
