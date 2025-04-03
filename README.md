# framework-plymouth

This is a boot logo for Plymouth that enables Framework's firmware image, while
also including a spinning Framework gear logo near the bottom.

Follow the steps below to use in a flake-enabled environment:

## 01. Add flake input

Inside your flake.nix file, add the following to your inputs:

```nix
inputs.framework-plymouth.url = "github:j-pap/framework-plymouth";
```

## 02. Set overlay

Add the input's overlay to your system:

```nix
nixpkgs.overlays = [ inputs.framework-plymouth.overlays.default ];
```

## 03. Declare plymouth theme

To use this package, set the theme and themePackages as below:

```nix
plymouth = {
  enable = true;
  theme = "framework";
  themePackages = [ pkgs.framework-plymouth ];
};
```

---

## Credits

I came across this theme created by [James Kupke](https://git.sr.ht/~jameskupke/framework-plymouth-theme)
and wanted to use it for NixOS, so I ended up making a few adjustments in the
derivation and packaging it up via this flake.
