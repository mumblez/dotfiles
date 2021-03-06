# This file was generated by https://github.com/kamilchm/go2nix v1.2.1
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "goose";
  version = "2017-07-07";
  rev = "056a4d47dcc4d67fa3947a4f13945a5c690e568b";

  goPackagePath = "github.com/pressly/goose";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/pressly/goose.git";
    sha256 = "1vgd08wkhrg6c9fgv1fx7kdibdd18b4qqshjvibqar50bn42imil";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
  };
}
