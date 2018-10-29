with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "python-environment";

  # ensure packages exist on https://nixos.org/nixos/packages.html#

  py = python3;

  # include python packages
  pythonPackages = py.withPackages(p: [
      p.GitPython
      p.pyyaml
      p.kubernetes
      p.gdal
  ]);

  # src = ./.;

  # include custom python packages (not available in nixpkgs)
  # pyDeps = callPackage ./pyDeps.nix

  # custom nix packages (that we can't find or override from <nixpkgs>)
  # relative to this default.nix file
  terraform = callPackage ./terraform-bin.nix {};
  _1password = callPackage ./onepassword-bin.nix {};
  # impure but can use env var to get path (treat the path as a string)
  vault = callPackage ((builtins.getEnv "AA") + "/vault-bin.nix") {};

  # python notes - https://nixos.org/nixpkgs/manual/#how-to-consume-python-modules-using-pip-in-a-virtualenv-like-i-am-used-to-on-other-operating-systems

  # include system packages here
  buildInputs = [
    jq
    git
    terraform
    vault
    py
    pythonPackages
  ];

  shellHook = ''
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
    export BBB="hello there"
  '';
}
