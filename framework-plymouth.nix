{
  stdenvNoCC,
  fetchFromSourcehut,
  lib,
  imagemagick
}:

stdenvNoCC.mkDerivation {
  name = "framework-plymouth";
  version = "2021-12-20";

  src = fetchFromSourcehut {
    owner = "~jameskupke";
    repo = "framework-plymouth-theme";
    rev = "b801f5bbf41df1cd3d1edeeda31d476ebf142f67";
    hash = "sha256-TuD+qHQ6+csK33oCYKfWRtpqH6AmYqvZkli0PtFm8+8=";
  };

  nativeBuildInputs = [
    imagemagick
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"/share/plymouth/themes
    cp -r framework/ "$out"/share/plymouth/themes
    for image in "$out"/share/plymouth/themes/framework/throbber*.png; do
      [[ -e "$image" ]] || break
      magick "$image" -resize 25% "$image";
    done
    sed -i '{
      8s/3/2/     # decrease title font size from 30 to 20
      11s/382/8/  # move dialog to .8 of screen
      13s/382/3/  # move title to .3 of screen
      15s/5/8/    # move logo to .8 of screen
      28s/^/UseFirmwareBackground=true\n/  # display FW image @ boot
      31s/^/UseFirmwareBackground=true\n/  # display FW image @ shutdown
      34s/^/UseFirmwareBackground=true\n/  # display FW image @ reboot
    }' "$out"/share/plymouth/themes/framework/framework.plymouth
    sed -i "s@/usr/@$out/@" "$out"/share/plymouth/themes/framework/framework.plymouth

    runHook postInstall
  '';

  meta = with lib; {
    description = "Plymouth boot theme with animated Framework logo";
    homepage = "https://git.sr.ht/~jameskupke/framework-plymouth-theme";
    license = licenses.mit;
    maintainers = [ "j-pap" ];
    platforms = platforms.linux;
  };
}
