with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";

  env = buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';

  goose = callPackage ./goose.nix {};

# already provided by stdenv so no need to add to buildInputs
# GNU coreutils (contains a few dozen standard Unix commands).
# GNU findutils (contains find).
# GNU diffutils (contains diff, cmp).
# GNU sed.
# GNU grep.
# GNU awk.
# GNU tar.
# gzip, bzip2 and xz.
# bash
# make
# patch
# On Linux, stdenv also includes the patchelf utility.


  buildInputs = [
    goose
    jq
  ];
}
