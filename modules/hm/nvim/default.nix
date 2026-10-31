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
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        luasnip
        cmp_luasnip
        friendly-snippets
        plenary-nvim
        telescope-nvim
        nvim-treesitter
      ];

      extraLuaConfig = ''
                                        local lspconfig = require("lspconfig")
                                	local capabilities = require("cmp_nvim_lsp").default_capabilities()
                        		local cmp = require("cmp")
                        		
                        		cmp.setup({
                        		  mapping = cmp.mapping.preset.insert({
                        		    ["<C-Space>"] = cmp.mapping.complete(),
                        		    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                        		  }),
                        		  sources = {
                        		    { name = "nvim_lsp" },
                        		    { name = "buffer" },
                        		    { name = "path" },
                        		  },
                        		})

                                	lspconfig.clangd.setup({
                                	  capabilities = capabilities,
                                	  cmd = { "clangd", "--background-index", "--clang-tidy" },
                                	})

                                	lspconfig.nixd.setup({
                                	  capabilities = capabilities,
        				})

                                	vim.api.nvim_create_autocmd("BufWritePre", {
                                          pattern = "*.nix",
                                	  callback = function()
                                	    vim.lsp.buf.format({ async = false })
                                	  end,
                                	})

                                	vim.api.nvim_create_autocmd("LspAttach", {
                                	  callback = function(event)
                                	    local opts = { buffer = event.buf }
                                	    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                                	    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                                	    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                                	    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                                	  end,
                                	})
      '';
    };

    home.packages = with pkgs; [
      clang-tools
      gcc
      cmake
      ninja
      gdb
      nixd
      nixfmt
    ];
  };
}
