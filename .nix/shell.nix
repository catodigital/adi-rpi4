let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};
  elixir = pkgs.beam.packages.erlangR25.elixir_1_14;
  erlang = pkgs.beam.packages.erlangR25.erlang;
  inherit (pkgs.lib) optional optionals;
in
with pkgs;
mkShell {
  name = "nervesShell";
  buildInputs = [
    autoconf
    automake
    bc
    coreutils
    curl
    elixir
    erlang
    file
    fwup
    git
    gnused
    gnutar
    libsodium
    mix2nix
    ncurses
    pkg-config-unwrapped
    rebar3
    squashfsTools
    wget
    which
  ]
    ++ optional stdenv.isDarwin coreutils-prefixed
    ++ optional stdenv.isLinux x11_ssh_askpass;

  shellHook = optionals stdenv.isLinux ''
    SUDO_ASKPASS=${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass
  '';

  CHUMAK_CURVE_LIB = "enacl";

  ERL_AFLAGS = "-kernel shell_history enabled";

  ERL_INCLUDE_PATH = "${elixir}/lib/erlang/usr/include";

  MIX_TARGET = "adi_rpi4";

  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    stdenv.cc.cc
    openssl
  ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
}
