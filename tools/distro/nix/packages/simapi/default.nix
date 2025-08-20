{ stdenv
, fetchFromGitHub
, cmake
, pkg-config
}:
let
  rev = "c6d144e309be32b1cd1d28a5721387a56f497333";
  version = builtins.substring 0 7 rev;
in
stdenv.mkDerivation {
  name = "simapi";
  inherit version;

  src = fetchFromGitHub {
    owner = "spacefreak18";
    repo = "simapi";
    inherit rev;
    hash = "sha256-GfKFznmnM1EeTIPc4+/C1J+y/6BE8ckSJxZHRjoPNig=";
    fetchSubmodules = true;
  };

  patches = [
    ./patches/fix-pc-paths.patch
  ];

  buildInputs = [
    cmake
    pkg-config
  ];
}
