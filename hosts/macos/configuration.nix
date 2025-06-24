{pkgs, pkgs-r2311, pkgs-unstable, ...}:
let
  defaultPkgs = import ../../common/packages;
in {
  nix.enable = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.stateVersion = 4;

  programs.bash.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
  };

  users.users.mateja.home = "/Users/mateja";
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mateja.imports = [ ../../modules/home-manager ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.commit-mono
    source-code-pro
  ];

  environment.systemPackages = with pkgs; [
    awscli
    coreutils
    gnupg
    iterm2
    k9s
    kubectl
    libreoffice-bin
    mariadb
    pkgs-unstable.claude-code
    stripe-cli
  ] ++ (defaultPkgs { inherit pkgs pkgs-r2311 pkgs-unstable; });

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
