{ stdenv, fetchzip }:
let
  arch = if stdenv.isLinux
         then "linux_amd64"
         else "darwin_amd64";
  checksum = if stdenv.isLinux
             then "09s5slaamkq6snrf4vxhi9qz4q702wcm48rnx990j6z3aq73lm23"
             else "05s8v37azvx1lic5d01s15rl138f6ds901kzz666kv70g5d5gsc3";
in
stdenv.mkDerivation rec {
  name = "terraform-${version}";
  version = "0.11.10";

  src = fetchzip {
    url = "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_${arch}.zip";
    sha256 = checksum;
    stripRoot = false;
  };


  installPhase = ''
    install -D terraform $out/bin/terraform
  '';
}
