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
  glib-networking,
  gsettings-desktop-schemas,
  gdk-pixbuf,
  libsoup_3,
  gst_all_1,
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

    nativeBuildInputs = [ makeWrapper glib ];

    meta = {
      description = "Omarchy visual theming application (extract palettes from wallpapers)";
      homepage = "https://github.com/omacom-io/aether";
      license = lib.licenses.mit;
      platforms = [ "x86_64-linux" ];
    };
  }
  ''
    install -D -m 755 "$src" "$out/bin/.aether-unwrapped"
    mkdir -p "$out/share/gsettings-schemas/aether/glib-2.0/schemas"
    for src_dir in "${gtk3.out}/share/gsettings-schemas/gtk+3-3.24.52" "${gsettings-desktop-schemas.out}/share/gsettings-schemas/${gsettings-desktop-schemas.name}"; do
      cp -L "$src_dir"/glib-2.0/schemas/*.gschema.xml \
        "$out/share/gsettings-schemas/aether/glib-2.0/schemas/" 2>/dev/null || true
    done
    glib-compile-schemas "$out/share/gsettings-schemas/aether/glib-2.0/schemas"
    makeWrapper "$out/bin/.aether-unwrapped" "$out/bin/aether" \
      --prefix LD_LIBRARY_PATH : "${runtimeLibs}" \
      --prefix XDG_DATA_DIRS : "$out/share" \
      --set GSETTINGS_SCHEMA_DIR "$out/share/gsettings-schemas/aether/glib-2.0/schemas" \
      --set GDK_PIXBUF_MODULE_FILE "${gdk-pixbuf.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache" \
      --set GIO_MODULE_DIR "${glib-networking}/lib/gio/modules" \
      --set GST_PLUGIN_SYSTEM_PATH "${lib.concatStringsSep ":" (map (p: "${p}/lib/gstreamer-1.0") [
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
      ])}"
  ''
