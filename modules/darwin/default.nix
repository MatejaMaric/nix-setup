{pkgs, ...}: {
  programs.bash.enable = true;
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.bash;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  users.users.mateja.home = "/Users/mateja";
  environment.systemPackages = with pkgs; [
    awscli
    buf
    cmake
    # coreutils
    fswatch
    gh
    # git
    # git-filter-repo
    go
    grpcurl
    # haskell-language-server
    jq
    # k9s
    # kubectl
    lf
    mariadb
    mpv
    # neovim
    nodejs_21
    pass
    passExtensions.pass-otp
    protoc-gen-go
    protoc-gen-go-grpc
    rustc
    # tmux
    yt-dlp
  ];
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
