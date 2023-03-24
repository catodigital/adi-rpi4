let
  sources = import ./sources.nix;
  pkgs = import /home/lyle/projects/nixpkgs {};
in with pkgs.pkgsCross.aarch64-multiplatform;
let
  packages = pkgsBuildTarget.beam.packages.erlangR25;
  src = ../.;

  pname = "adi-rpi4";
  version = "0.0.1";
  mixEnv = "prod";

  mixNixDeps = import ./deps.nix {
    inherit lib;
    beamPackages = packages;
  };

in packages.mixRelease {
  inherit src pname version mixEnv mixNixDeps;
  MIX_TARGET = "adi_rpi4";
  RELEASE_COOKIE = "adi-rpi4";
}
