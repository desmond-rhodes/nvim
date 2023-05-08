vim.opt.mouse = ''
vim.opt.guicursor = ''

vim.cmd.filetype('plugin off')
vim.cmd.filetype('indent off')

vim.opt.autoindent = false

vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
	print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{'morhetz/gruvbox'},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			require('nvim-treesitter.install').update({ with_sync = true })
		end
	},
	{'mbbill/undotree'},
	{
		'nvim-tree/nvim-tree.lua',
		version = '*',
		config = function()
			require('nvim-tree').setup {}
		end
	}
})

-- Set colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme('gruvbox')
vim.opt.background = 'light'

-- LSP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
	'clangd'
})

lsp.setup()

require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'bash', 'c', 'cmake', 'cpp', 'css', 'dockerfile', 'git_config', 'gitignore', 'glsl', 'html', 'java', 'javascript', 'jsdoc', 'json', 'latex', 'lua', 'luadoc', 'make', 'markdown', 'matlab', 'passwd', 'python', 'query', 'regex', 'sql', 'vim', 'vimdoc'
	},
	highlight = {
		enable = true
	}
}

vim.opt.undodir = os.getenv('HOME') .. '/.cache/undotree'
vim.opt.undofile = true
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OR setup with some options
require('nvim-tree').setup({
	sort_by = 'case_sensitive',
	renderer = {
		icons = {
			show = {
				file = false,
				folder = false
			},
			glyphs = {
				folder = {
					arrow_closed = '⏵',
					arrow_open = '⏷'
				}
			}
		}
	}
})
vim.keymap.set('n', '<leader>t', vim.cmd.NvimTreeToggle)
