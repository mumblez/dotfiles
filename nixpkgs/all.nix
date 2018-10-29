# not really a real derivation, install with nix-env, e.g.
# nix-env -f ~/dotfiles/nixpkgs/all.nix -i -A terraform
with import <nixpkgs> {};

stdenv.mkDerivation rec {
  _1password = callPackage ./onepassword.nix {};
  terraform = callPackage ./terraform.nix {};
}
