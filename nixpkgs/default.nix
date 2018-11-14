with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "debug-env";

  # ensure packages exist on https://nixos.org/nixos/packages.html#

  kubectl = callPackage ./kubectl.nix {};
  helm = callPackage ./helm.nix {inherit kubectl;};
  terraform = callPackage ./terraform.nix {};
  # awscli = callPackage ./awscli.nix {};

  buildInputs = [
    kubectl
    helm
    awscli
    terraform
  ];

  shellHook = ''
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
    export BBB="hello there"
  '';
}
