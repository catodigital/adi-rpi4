{ lib, beamPackages, overrides ? (x: y: {}) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; {
    castore = buildMix rec {
      name = "castore";
      version = "0.1.18";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "01kawrhxcc0i7zkygss5ia8hmkzv39q4bnrwnf0fz0mpa9jazfv1";
      };

      beamDeps = [];
    };

    earmark_parser = buildMix rec {
      name = "earmark_parser";
      version = "1.4.29";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "00rmqvf3hkxfvkijqd624n0hn1xqims8h211xmm02fdi7qdsy0j9";
      };

      beamDeps = [];
    };

    elixir_make = buildMix rec {
      name = "elixir_make";
      version = "0.6.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "05ppvbhqi5m9zk1c4xnrki814sqhxrc7d1dpvfmwm2v7qm8xdjzm";
      };

      beamDeps = [];
    };

    ex_doc = buildMix rec {
      name = "ex_doc";
      version = "0.29.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1caxmx8zdhjbkm625l607xmljbbrqxhk68kqs8spsryapfwav5ph";
      };

      beamDeps = [ earmark_parser makeup_elixir makeup_erlang ];
    };

    makeup = buildMix rec {
      name = "makeup";
      version = "1.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "19jpprryixi452jwhws3bbks6ki3wni9kgzah3srg22a3x8fsi8a";
      };

      beamDeps = [ nimble_parsec ];
    };

    makeup_elixir = buildMix rec {
      name = "makeup_elixir";
      version = "0.16.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1rrqydcq2bshs577z7jbgdnrlg7cpnzc8n48kap4c2ln2gfcpci8";
      };

      beamDeps = [ makeup nimble_parsec ];
    };

    makeup_erlang = buildMix rec {
      name = "makeup_erlang";
      version = "0.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fvw0zr7vqd94vlj62xbqh0yrih1f7wwnmlj62rz0klax44hhk8p";
      };

      beamDeps = [ makeup ];
    };

    nerves = buildMix rec {
      name = "nerves";
      version = "1.9.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0mlss1raylpk9wvlxi1k68b915sjmd0w4v8a4nmxpq93d48hj501";
      };

      beamDeps = [ castore elixir_make ];
    };

    nerves_system_br = buildMix rec {
      name = "nerves_system_br";
      version = "1.21.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1vma6zp515vna0n2qskaxldpv5h063clcgliv3iqr4pb85f3xpa3";
      };

      beamDeps = [];
    };

    nerves_system_linter = buildMix rec {
      name = "nerves_system_linter";
      version = "0.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "10jzxjhky72pmk7nvpqbzxmgggclyp91zx0zc3s1fqvsrs089gdm";
      };

      beamDeps = [];
    };

    nerves_toolchain_aarch64_nerves_linux_gnu = buildMix rec {
      name = "nerves_toolchain_aarch64_nerves_linux_gnu";
      version = "1.6.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0k0fbrpbx2ncc50db8dgzsgvxldrlryqx35ivym2ax4wz0nirvap";
      };

      beamDeps = [ nerves nerves_toolchain_ctng ];
    };

    nerves_toolchain_ctng = buildMix rec {
      name = "nerves_toolchain_ctng";
      version = "1.9.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0xvb25y858yay8j8sxvviivcbl8z042d2s8bs37jd1l45jw1542s";
      };

      beamDeps = [ nerves ];
    };

    nimble_parsec = buildMix rec {
      name = "nimble_parsec";
      version = "1.2.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1c3hnppmjkwnqrc9vvm72kpliav0mqyyk4cjp7vsqccikgiqkmy8";
      };

      beamDeps = [];
    };
  };
in self

