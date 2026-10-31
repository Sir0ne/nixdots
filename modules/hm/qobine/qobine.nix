{
  lib,
  alsa-lib,
  openssl,
  protobuf,
  pkg-config,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "qobine-tui";
  version = "2026-10-27";

  src = fetchFromGitHub {
    owner = "SofusA";
    repo = "qobine";
    tag = "v${finalAttrs.version}";
    hash = "";
  };

  cargoHash = lib.fakeHash;

  cargoBuildFlakgs = [
    "--package"
    "tui-module"
  ];

  env.SQLX_OFFLINE = "true";

  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildInputs = [
    alsa-lib
    openssl
  ];

  doCheck = false;

  meta = {
    description = "Terminal UI for Qobuz";
    homepage = "https://github.com/SofusA/qobine";
    changelog = "https://github.com/SofusA/qobine/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "qobine-tui";
  };
})
