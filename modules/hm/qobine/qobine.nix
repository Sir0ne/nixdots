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

  # No git dependencies, so the repo's own lockfile is enough (no cargoHash).
  cargoLock.lockFile = "${finalAttrs.src}/Cargo.lock";

  # Build only the terminal UI, not the web / rfid / gtk / connect players.
  buildAndTestSubdir = "tui-module";
  cargoBuildFlags = [
    "--package"
    "tui-module"
    "--bin"
    "qobine-tui"
  ];

  # sqlx's query! macros use the checked-in metadata in player-module/.sqlx
  # instead of needing a live database at build time.
  env.SQLX_OFFLINE = "true";

  nativeBuildInputs = [
    pkg-config
    cmake # only for aws-lc-sys's build script
  ];
  dontUseCmakeConfigure = true;

  buildInputs = [
    alsa-lib # audio output (rodio/cpal)
    openssl # native-tls
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
