{ stdenv, fetchFromGitHub, hugo }:
stdenv.mkDerivation {
  name = "blog";
  src = fetchFromGitHub {
    owner = "MatejaMaric";
    repo = "blog";
    rev = "bb7193cf1f1b2e1662150400164b0b07e646b4a5";
    hash = "sha256-MAOa7pHEIPijRulc0oz+KCd6dZ1WgShEmnrX1isuHBU=";
  };
  buildInputs = [ hugo ];
  buildPhase = ''
    hugo
  '';
  installPhase = ''
    mkdir -p $out/var/www
    cp -r public $out/var/www/matejamaric.com
  '';
}
