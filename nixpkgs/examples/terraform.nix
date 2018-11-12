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
    # stripRoot moves files up one directory level, useful for when archive is of a folder
    stripRoot = false;
  };

  # src = (baseNameOf url);

  # buildInputs = [ 
  #   wget
  #   unzip
  # ];

  # phases = [ "buildPhase" "installPhase" ];

  # with hash
  # buildPhase = ''
  #   mkdir -p $out/bin
  # '';

  # url = "https://releases.hashicorp.com/terraform/${version}/${name}_${version}_${arch}.zip";
  # just download, no hash
  # buildPhase = ''
  #   mkdir -p $out/bin
  #   export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  #   echo "Downloading $url..."
  #   wget -q "$url"
  # '';

  # installPhase = ''
  #   echo "source = $src"
  #   unzip $src -d $out/bin
  #   chmod +x $out/bin/${name}
  # '';

  installPhase = ''
    install -D terraform $out/bin/terraform
  '';

  meta = with stdenv.lib; {
    homepage = https://terraform.io;
  };
}
