{ stdenv, fetchurl }:
let
  os = if stdenv.isLinux
         then "linux"
         else "darwin";
  checksum = if stdenv.isLinux
             then "1iwa0kyb5flzmqh7z6pfw6bawycgliirj8gbjr5ad9p52xc7p020"
             else "06dv7d9l62ab15h3swq057sbhbgfxv931x3hhrjfgcyr4brjnybj";
in
stdenv.mkDerivation rec {
  name = "kubectl-${version}";
  version = "v1.12.2";

  src = fetchurl {
    url = "https://storage.googleapis.com/kubernetes-release/release/${version}/bin/${os}/amd64/kubectl";
    sha256 = checksum;
  };

  phases = [ "installPhase" ];

  installPhase = ''
    install -D $src $out/bin/kubectl
  '';

}
