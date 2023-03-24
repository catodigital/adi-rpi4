let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};
  cross = pkgs.pkgsCross.raspberryPi;
in
with cross;
mkShell {
  buildInputs = [
    automake
    gcc
  ];

  CHUMAK_CURVE_LIB = "enacl";
}
