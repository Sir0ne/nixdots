{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cmake,
  alsa-lib,
  openssl,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "qobine-tui";
  version = "2026-10-31";

  src = fetchFromGitHub {
    owner = "SofusA";
    repo = "qobine";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/BasGIAfVcE43OFB1gz290UTwvxUQcelalLMgYy6InQ=";
  };

  cargoLock.lockFile = "${finalAttrs.src}/Cargo.lock";

  buildAndTestSubdir = "tui-module";
  cargoBuildFlags = [
    "--package"
    "tui-module"
    "--bin"
    "qobine-tui"
  ];

  env.SQLX_OFFLINE = "true";

  nativeBuildInputs = [
    pkg-config
    cmake
  ];
  dontUseCmakeConfigure = true;

  buildInputs = [
    alsa-lib
    openssl
  ];

  doCheck = false;

  meta = {
    description = "Terminal UI player for Qobuz (qobine)";
    homepage = "https://github.com/SofusA/qobine";
    changelog = "https://github.com/SofusA/qobine/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "qobine-tui";
  };
})
