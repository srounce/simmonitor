{ pkgs, stdenv }:
stdenv.mkDerivation {
  pname = "hoel";
  version = "2024-03-04";

  src = pkgs.fetchFromGitHub {
    owner = "babelouest";
    repo = "hoel";
    rev = "33598d2c8defc4eeff208249b5bed67c7ed62e48";
    sha256 = "sha256-ZOCVStiljdCcdG4mBnREUPhJOo+VTxUzA+BxKWQt5hA=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
    orcania
    jansson
    libpq
    libpq.pg_config
    yder
  ];

  cmakeFlags = [
    "-DWITH_MARIADB=off"
    "-DWITH_SQLITE3=off"
    "-DCMAKE_INSTALL_PREFIX=$out"
  ];
}
