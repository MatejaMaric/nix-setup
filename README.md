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

### Server VM (testing):

Sadly, using this command you can build VMs only for Linux. Building VMs on MacOS (especially on M1) is to much of a hassle for me personally.

```bash
nixos-rebuild build-vm --flake .#server
./result/bin/run-server-vm
```

You can SSH into a VM using:

```bash
ssh -p 50000 localhost
```

You might want do delete the state of the previous VM instance:

```bash
rm server.qcow2
```

## How to update packages:

You can update the flake using this command, which is going to update the flake lock file:

```bash
nix flake update
```

After than you can update the system itself by switching into the flake with
`nixos-rebuild switch` or `darwin-rebuild switch` depending on the platform you
use.

You can also use this, if you are feeling too lazy to commit the changes yourself:

```
nix flake update --commit-lock-file
```

## How to update a single flake input:

Here's an example for updating `matejasblog` package:

```bash
nix flake lock --update-input matejasblog
```

## How to optimise storage:

List all of the available generations:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

Remove all but the current generation:

```bash
sudo nix-collect-garbage -d
```

Garbage collect unneeded entires:

```bash
nix-store --gc
```

Optimise the store by manually running the command (potentially long operation):

```bash
sudo nix-store --optimise
```
For more checkout the [documentation](https://nixos.wiki/wiki/Storage_optimization).
