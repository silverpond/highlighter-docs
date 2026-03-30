{
  description = "Highlighter Documentation";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.silverpond-nix = {
    url = "github:silverpond/silverpond-nix";
    flake = false;
  };
  outputs = { self, nixpkgs, flake-compat, silverpond-nix }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          silverpondOverrides = import "${silverpond-nix}/python-overrides.nix" { inherit pkgs; };
          # Layer our own fix on top: relax litellm version constraint
          pythonOverrides = pyfinal: pyprev:
            let base = silverpondOverrides pyfinal pyprev;
            in base // {
              highlighter-sdk = base.highlighter-sdk.overridePythonAttrs (old: {
                pythonRelaxDeps = (old.pythonRelaxDeps or [ ]) ++ [ "litellm" ];
              });
            };
          python = pkgs.python3.override {
            packageOverrides = pythonOverrides;
            self = python;
          };
          pythonWithSdk = python.withPackages (ps: [ ps.highlighter-sdk ]);
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.zola
              pkgs.just
              pythonWithSdk
              pkgs.pyright
            ];
          };
        }
      );
    };
}
