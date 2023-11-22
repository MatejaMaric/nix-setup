```bash
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.Matejas-MacBook-Pro.local.system
./result/sw/bin/darwin-rebuild switch --flake ~/macos-nix-setup
darwin-rebuild switch --flake ~/macos-nix-setup/.#
```

https://discourse.nixos.org/t/migrating-from-homebrew-to-nix-for-osx/2892/1

- Get used to scoping out brew leaves to see what you currently use from Homebrew rather than brew list which will lump in dependencies.
- Start with brew unlink instead of brew uninstall, don’t just go cold-turkey, especially if you rely on this stuff professionally

