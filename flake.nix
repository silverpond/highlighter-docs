{
  description = "Highlighter Documentation";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  outputs = { self, nixpkgs, flake-compat }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        { default = pkgs.mkShell { buildInputs = with pkgs;[ zola just python3 ]; }; }
      );
    };
}
