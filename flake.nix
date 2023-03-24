{
  description = "ADI Nerves System for RaspberryPi 4";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs.lib) optional;
        pkgs = import nixpkgs { inherit system; };

        erlangV = "erlangR25";
        elixirV = "elixir_1_14";

        erlang = pkgs.beam.interpreters.${erlangV};
        elixir = pkgs.beam.packages.${erlangV}.${elixirV};
        elixir_ls = pkgs.beam.packages.${erlangV}.elixir_ls;

        libPath = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc
          pkgs.openssl
        ];
      in {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            autoconf
            automake
            bc
            coreutils
            curl
            elixir
            file
            fwup
            git
            gnused
            gnutar
            ncurses
            perl
            perlPackages.ExtUtilsMakeMaker
            pkg-config-unwrapped
            rebar3
            rsync
            squashfsTools
            x11_ssh_askpass
            wget
            which
          ]
            ++ optional stdenv.isDarwin coreutils-prefixed
            ++ optional stdenv.isLinux x11_ssh_askpass;

          NIX_LD_LIBRARY_PATH = libPath;
          NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
        };
      }
  );
}
