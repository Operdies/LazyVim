local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/bufferline.nvim" })
	use({ "moll/vim-bbye" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "goolord/alpha-nvim" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim" })
	use({ "xiyaowong/nvim-transparent" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	--[[ use { "saadparwaiz1/cmp_luasnip" } -- snippet completions ]]
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	-- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "ravenxrz/DAPInstall.nvim" })

	-- MikaelElkiaer/
	use({
		"XXiaoA/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")

					if
						fn.getbufvar(buf, "&modifiable") == 1
						and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
						and utils.not_in(fn.expand("%:t"), {
							"plugins.lua",
							"auto-save.lua",
						})
					then
						return true -- met condition(s), can save
					end
					return false -- can't save
				end,
			})
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		requires = "nvim-treesitter",
	})
	use({
		"Hoffs/omnisharp-extended-lsp.nvim", -- goto definition for external symbols
		requires = { { "nvim-telescope/telescope.nvim" } },
	})
	use({ "vim-test/vim-test" }) -- run tests based on context
	use({ "metakirby5/codi.vim" }) -- scratchpad for scripting
	use({
		"nvim-telescope/telescope-ui-select.nvim", -- use telescope for various ui inputs
		requires = { { "nvim-telescope/telescope.nvim" } },
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	})
	-- use {
	--   "danymat/neogen", -- generate c# xml doc
	--   config = function()
	--     require('neogen').setup {
	--       languages = {
	--         cs = {
	--           template = {
	--             annotation_convention = "xmldoc"
	--           }
	--         }
	--       }
	--     }
	--   end,
	--   requires = "nvim-treesitter/nvim-treesitter"
	-- }
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" }) -- lsp signature (method overloads etc.)
	use({ "folke/which-key.nvim" }) -- mini cheatsheet for keymaps on demand
	use({
		"tiagovla/scope.nvim", -- limit visible buffers to active tab
		config = function()
			require("scope").setup()
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context", -- display parent context for nested constructs
		requires = "nvim-treesitter/nvim-treesitter",
	})
	use({
		"ziontee113/syntax-tree-surfer", -- navigate and move constructs
		config = function()
			require("syntax-tree-surfer").setup({})
		end,
	})
	use({
		"akinsho/git-conflict.nvim", -- navigate and simple view of git conflicts
		config = function()
			require("git-conflict").setup()
		end,
	})
	use({
		"glepnir/lspsaga.nvim", -- lsp UI enhancements
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				code_action_lightbulb = {
					sign = false,
					enable_in_insert = false,
				},
			})
		end,
	})
	use({
		"iamcco/markdown-preview.nvim", -- markdown browser preview and sync
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		requires = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	})
	use({
		"lmburns/lf.nvim",
		config = function()
			-- This feature will not work if the plugin is lazy-loaded
			vim.g.lf_netrw = 1

			require("lf").setup({
				escape_quit = true,
			})
		end,
		requires = { "plenary.nvim", "toggleterm.nvim" },
	})
	-- Alex
  use({"tpope/vim-surround"})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
