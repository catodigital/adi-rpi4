let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};
in
pkgs.dockerTools.buildLayeredImage {
  name = "adi_supervisor";
  tag = "latest";
  contents = import ./default.nix;
  config.Cmd = "/bin/adi_supervisor start";
}
