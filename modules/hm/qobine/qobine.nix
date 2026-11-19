{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cmake,
  alsa-lib,
  openssl,
  sqlite,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "qobine-tui";
  version = "2026-11-13";

  src = fetchFromGitHub {
    owner = "SofusA";
    repo = "qobine";
    tag = "v${finalAttrs.version}";
    hash = "sha256-gbB34tFh7BsHD8guS3T9MUzmDwr1zjZaRHwUz9fkjP0=";
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
    sqlite
  ];

  preBuild = "unset AWS_LC_SYS_USE_SYSTEM";

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
