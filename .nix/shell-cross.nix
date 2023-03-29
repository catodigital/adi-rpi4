let
  pkgs = import /home/lyle/projects/nixpkgs {};
  elixir = pkgs.beam.packages.erlangR25.elixir_1_14;
  erlang = pkgs.beam.packages.erlangR25.erlang;
in
with pkgs;
mkShell {
  buildInputs = [
    elixir
    erlang
    fwup
    mix2nix
  ] ++ (with pkgs.pkgsCross.aarch64-multiplatform; [
    autoconf
    automake
    bc
    beam.packages.erlangR25.elixir_1_14
    beam.packages.erlangR25.erlang
    cpio
    curl
    file
    gcc
    gnused
    gnutar
    ncurses
    openssl
    patch
    perl
    python3
    rebar3
    rsync
    squashfsTools
    unzip
    wget
    which
    # Using the pkg-config-unwrapped ensures we use the libnl from the nerves
    # system
    pkg-config-unwrapped
  ]);

  shellHook = ''
    # ERL_LIBS causes a load of compile warnings (warning: this clause cannot
    # match because of a previous clause at line 1 that always matches) in the
    # standard library. It appears to be because things are evaluated twice.
    # An actual export -n isn't inherited properly so we just set it blank.
    export ERL_LIBS=""
  '';

  HOSTCC = "${pkgs.pkgsCross.aarch64-multiplatform.gcc}/bin/gcc";
  HOSTCXX = "${pkgs.pkgsCross.aarch64-multiplatform.gcc}/bin/g++";

  ERL_AFLAGS = "-kernel shell_history enabled";

  ERL_INCLUDE_PATH = "${elixir}/lib/erlang/usr/include";

  MIX_TARGET = "adi_rpi4";
}
