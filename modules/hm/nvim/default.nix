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

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      waylandSupport = true;

      extraPackages = with pkgs; [
        nixd
	nixfmt
	rust-analyzer
	clippy
      ];

      plugins = with pkgs.vimPlugins; [
	nvim-lspconfig
	friendly-snippets
	{
	  plugin = blink-cmp;
	  type = "lua";
	  config = ''
	    require('blink.cmp').setup({
	      keymap = { preset = 'enter' },
	      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
	    })
	  '';
	}
      ];

      initLua = ''
        -- NIX LSP --
        vim.lsp.config('nixd', {
	  settings = {
	    nixd = {
	      nixpkgs = { expr = 'import <nixpkgs> { }' },
	      formatting = { command = { 'nixfmt' } },
	      options = {
		nixos = {
		  expr = '(builtins.getFlake "/home/goofy/dotfiles").nixosConfigurations.goofy.options',
		},
	      },
	    },
	  },
	})
	vim.lsp.enable('nixd')

	-- RUST LSP --
	vim.lsp.config('rust_analyzer', {
	  capabilities = require('blink.cmp').get_lsp_capabilities(),
	})
	vim.lsp.enable('rust_analyzer')
      '';
    };
  };
}
