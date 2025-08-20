{
  description = "simmonitor";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    internalPkgs = {
      hoel = callPackage ./packages/hoel.nix { };
      simapi = callPackage ./packages/simapi { };
      simmonitor = callPackage ./packages/simmonitor.nix { };
    };
    callPackage = pkgs.newScope (pkgs // internalPkgs);
  in {
    packages.${system} = {
      inherit(internalPkgs) simmonitor;
      default = internalPkgs.simmonitor;
    };
  };
}
