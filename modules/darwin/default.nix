{pkgs, ...}: {
  programs.bash.enable = true;
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.bash;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  environment.systemPackages = with pkgs; [
    awscli
    buf
    cmake
    coreutils
    fswatch
    gh
    git-filter-repo
    go
    grpcurl
    haskell-language-server
    jq
    k9s
    kubectl
    mariadb
    mpv
    neovim
    nodejs_21
    openvpn
    pass
    passExtensions.pass-otp
    protoc-gen-go
    protoc-gen-go-grpc
    ranger
    rustc
    tmux
  ];
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
