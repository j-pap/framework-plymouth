{
  description = "Plymouth boot theme with animated Framework logo";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    eachSystem = nixpkgs.lib.genAttrs systems;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  in {
    overlays.default = final: prev: {
      framework-plymouth = prev.callPackage ./framework-plymouth.nix { };
    };

    packages = eachSystem (system: {
      default = self.packages.${system}.framework-plymouth;
      framework-plymouth = nixpkgs.legacyPackages.${system}.callPackage ./framework-plymouth.nix { };
    });
  };
}
