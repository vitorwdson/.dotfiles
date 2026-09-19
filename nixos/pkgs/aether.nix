# Aether - Omarchy theming GUI (image -> colors.toml theme).
# Not in nixpkgs; upstream ships a prebuilt linux binary with every release.
# The binary links system libs (GTK3 + WebKitGTK 4.1, it is a Wails app), so
# we wrap it with the nixpkgs equivalents at runtime.
{
  lib,
  runCommand,
  makeWrapper,
  fetchurl,
  gtk3,
  webkitgtk_4_1,
  glib,
  gdk-pixbuf,
  libsoup_3,
}:

let
  version = "4.29.9";
  runtimeLibs = lib.makeLibraryPath [
    gtk3
    webkitgtk_4_1
    glib
    gdk-pixbuf
    libsoup_3
  ];
in
runCommand "aether-${version}"
  {
    src = fetchurl {
      url = "https://github.com/omacom/aether/releases/download/v${version}/aether-linux-amd64";
      hash = "sha256-BzeEYgoYkx6PE4np6einDa4UWOztpvzmCK4SkPd77pk=";
    };

    nativeBuildInputs = [ makeWrapper ];

    meta = {
      description = "Omarchy visual theming application (extract palettes from wallpapers)";
      homepage = "https://github.com/omacom-io/aether";
      license = lib.licenses.mit;
      platforms = [ "x86_64-linux" ];
    };
  }
  ''
    install -D -m 755 "$src" "$out/bin/.aether-unwrapped"
    makeWrapper "$out/bin/.aether-unwrapped" "$out/bin/aether" \
      --prefix LD_LIBRARY_PATH : "${runtimeLibs}" \
      --prefix XDG_DATA_DIRS : "$out/share:${gtk3}/share:${glib}/share" \
      --set GIO_MODULE_DIR "${webkitgtk_4_1}/lib/gio/modules"
  ''
