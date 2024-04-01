let
  pkgs = import <nixpkgs> { };
in pkgs.stdenv.mkDerivation {
  name = "blog";
  src = pkgs.fetchFromGitHub {
    owner = "MatejaMaric";
    repo = "blog";
    rev = "bb7193cf1f1b2e1662150400164b0b07e646b4a5";
    sha256 = null;
  };
  buildInputs = [ pkgs.hugo ];
  buildPhase = ''
    hugo
  '';
  installPhase = ''
    cp -r public $out
  '';
}
