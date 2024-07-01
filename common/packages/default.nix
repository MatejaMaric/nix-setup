pkgs: pkgs-unstable: with pkgs; [
  (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
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
  htop
  httpie
  jq
  lf
  pkgs-unstable.lunarvim
  mpv
  neovim
  nil
  nodejs_22
  pkgs-unstable.go
  protobuf
  protoc-gen-go
  protoc-gen-go-grpc
  rustc
  tmux
  transmission-gtk
  tree
  unzip
  wget
  yt-dlp
  zip
]
