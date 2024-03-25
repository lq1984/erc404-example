let
  hostPkgs = import <nixpkgs> {};
  nixpkgsForNode18_12_1 = import (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "57ea1f2119a2339e42e89d0412dc8b2a45086740";
    sha256 = "sha256-NTpJO635WZFq5WNzSslqR3+aOaFjUlmC6aosSw9iaxQ=";
  }) {};
in
hostPkgs.mkShell {
  buildInputs = [
    nixpkgsForNode18_12_1.nodejs
    hostPkgs.yarn-berry
    hostPkgs.corepack
    hostPkgs.proxychains
  ];
}