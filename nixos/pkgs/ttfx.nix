# ttfx - terminal text effects (Rust port of terminaltexteffects).
# Used by the omarchy screensaver. Not in nixpkgs; built from the omacom-io
# source release (no prebuilt binaries published upstream).
{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "ttfx";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "omacom-io";
    repo = "ttfx";
    rev = "v${version}";
    hash = "sha256-bwFjC6ZkZibkgXjoYVH2VuqqeXklGR9kmRl2fTitWBU=";
  };

  cargoHash = "sha256-DNrg12MNqBcQi6yvoJObM1gtE90iGBCxeQ3RwueYCE4=";

  meta = {
    description = "Terminal text effects as a single static binary";
    homepage = "https://github.com/omacom-io/ttfx";
    license = lib.licenses.mit;
  };
}
