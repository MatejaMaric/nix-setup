{pkgs, ...}: {
  programs.bash.enable = true;
  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.bash;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  users.users.mateja.home = "/Users/mateja";
  environment.systemPackages = with pkgs; [
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    awscli
    buf
    cmake
    coreutils
    ffmpeg
    fswatch
    gh
    gimp
    git
    git-filter-repo
    gnupg
    go
    grpcurl
    haskell-language-server
    iterm2
    jq
    k9s
    kubectl
    lf
    libreoffice-bin
    mariadb
    mpv
    neovim
    nodejs_21
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    rustc
    tmux
    tree
    yt-dlp
  ];
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
