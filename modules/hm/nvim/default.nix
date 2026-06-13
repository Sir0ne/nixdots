{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.nvim;
in
{
  options.modules.nvim = {
    enable = mkEnableOption "neovim";
  };
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        nvim-lint
        conform-nvim
      ];

      initLua = ''
        -- Configure Linting (Statix & Deadnix)
        local lint = require('lint')
        lint.linters_by_ft = {
          nix = { 'statix', 'deadnix' },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
          callback = function()
            lint.try_lint()
          end,
        })

        local conform = require('conform')
        conform.setup({
          formatters_by_ft = {
            nix = { 'nixfmt' },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
          },
        })
      '';
    };

    home.packages = with pkgs; [
      statix
      deadnix
      nixfmt-rfc-style
    ];
  };
}
