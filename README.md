```bash
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.Matejas-MacBook-Pro.system
./result/sw/bin/darwin-rebuild switch --flake ~/macos-nix-setup
darwin-rebuild switch --flake ~/macos-nix-setup/.#
```
