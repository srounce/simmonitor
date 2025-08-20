{ pkgs
, lib
, autoPatchelfHook
, stdenv
, simapi
, hoel
, argtable
, hidapi
, lua53Packages
, libconfig
, libpulseaudio
, libserialport
, libuv
, libusb1
, libxml2
, libxdg_basedir
, ncurses
, freetype
, libmicrohttpd
, SDL2
, SDL2_image
, libtar
, jansson
, libpq
, libdrm
, libwebp
, libtiff
, xorg
, yder
, orcania
, postgresql
}:
stdenv.mkDerivation {
  pname = "simmonitor";
  version = "1.0.0";

  src =  ./../../../..;

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = [
    simapi
    hoel
    argtable
    hidapi
    lua53Packages.lua
    libconfig
    libpulseaudio
    libserialport
    libuv
    libusb1
    libxml2
    libxdg_basedir
    ncurses
    freetype
    libmicrohttpd
    SDL2
    SDL2_image
    libtar
    jansson
    libpq
    libdrm
    libwebp
    libtiff
    xorg.libX11
    yder
    orcania
    postgresql
    autoPatchelfHook
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$(out)"
    "-Wno-dev"
  ];

  postPatch = ''
    substituteInPlace src/simmonitor/helper/parameters.c \
      --replace-warn 'argtable2.h' 'argtable3.h'

    substituteInPlace $(find . -name CMakeLists.txt) \
      --replace-warn 'argtable2' 'argtable3'
  '';

   installPhase = ''
     mkdir -p $out/bin

     install -m755 -D simmonitor $out/bin/simmonitor
   '';

  meta = with pkgs.lib; {
    description = "Customizable Simulator dashboards and telemetry data logger";
    homepage = "https://github.com/Spacefreak18/simmonitor";
    license = licenses.gpl3Only;
    # maintainers = [ maintainers.yourName ];  # Replace with your name
    platforms = platforms.linux;
  };
}
