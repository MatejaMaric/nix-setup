{ pkgs, pkgs-r2311, pkgs-unstable }: with pkgs; [
  (pass.withExtensions (exts: [ exts.pass-otp ]))
  alacritty
  buf
  cmake
  elmPackages.elm
  ffmpeg
  fswatch
  gh
  gimp
  git
  git-filter-repo
  gnumake
  grpcurl
  haskell-language-server
  hledger
  htop
  httpie
  jq
  lf
  mpv
  neovim
  nil
  nodejs_22
  pciutils
  pkgs-r2311.lunarvim
  pkgs-unstable.go
  protobuf
  protoc-gen-go
  protoc-gen-go-grpc
  python312
  python312Packages.dateutils
  rustc
  tmux
  transmission_3-gtk
  tree
  unzip
  wget
  yt-dlp
  zip
]
