{pkgs, pkgs-unstable, ...}:
let
  defaultPkgs = import ../../common/packages;
in {
  programs.bash.enable = true;
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.bash;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  users.users.mateja.home = "/Users/mateja";
  environment.systemPackages = with pkgs; [
    awscli
    coreutils
    gnupg
    iterm2
    k9s
    kubectl
    libreoffice-bin
    mariadb
    stripe-cli
  ] ++ (defaultPkgs pkgs pkgs-unstable);
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
