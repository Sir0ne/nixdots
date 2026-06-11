{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.vesktop;
in {
  options.modules.vesktop = {enable = mkEnableOption "vesktop";};
  config = mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      vencord.settings = {
        font = "Helvetica";
      };
      settings = {font = "Helvetica";};
      vencord.extraQuickCss = ''
        :root {
          /* Force ONLY Helvetica. If you include gg sans here, ligatures will break */
          --font-primary: "Helvetica" !important;
          --font-display: "Helvetica" !important;
          --font-headline: "Helvetica" !important;
          --font-code: "Helvetica", monospace !important;
        }

        /* Strict instructions to kick Electron's layout rules into feature substitution mode */
        body, textarea, input, button, select, span, div, ::placeholder {
          font-family: "Helvetica" !important;
          font-feature-settings: "liga" on, "clig" on !important;
          font-variant-ligatures: common-ligatures discretionary-ligatures !important;
          text-rendering: optimizeLegibility !important;
        }

      '';
    };
  };
}
