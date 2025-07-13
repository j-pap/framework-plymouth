{
  description = "Plymouth boot theme with animated Framework logo";

  outputs = { self }: {
    overlays.default = final: prev: {
      framework-plymouth = prev.callPackage ./framework-plymouth.nix {};
    };
  };
}
