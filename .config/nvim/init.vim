lua << EOF
vim.g.mapleader = ";"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({

{ 'echasnovski/mini.files', version = false }, --file explorer
{ 'echasnovski/mini.indentscope', version = '*' }, --scop visualier
 --"zbirenbaum/copilot.lua" , -- github copilot
 "github/copilot.vim",
 
 "nvim-treesitter/nvim-treesitter" , --syntax hightlight 
 'simrat39/symbols-outline.nvim', -- code outline
 "NvChad/nvim-colorizer.lua" , --color preview
 -- Language server and auto completion plugins
 "neovim/nvim-lspconfig" , -- built-in LSP
 "williamboman/mason.nvim" , --Easily install and manage LSP servers, DAP servers, linters, and formatters.
 "williamboman/mason-lspconfig.nvim" , --LSP installer
--  "williamboman/nvim-lsp-installer" , -- language server auto installer
 "hrsh7th/cmp-nvim-lsp" , --auto completion suite
 "hrsh7th/cmp-buffer",
 "hrsh7th/cmp-path",
 "hrsh7th/cmp-cmdline",
 "hrsh7th/cmp-vsnip",
 "hrsh7th/vim-vsnip",
 "dcampos/nvim-snippy",
 "dcampos/cmp-snippy",
 "hrsh7th/nvim-cmp",
 "aznhe21/actions-preview.nvim",
 "onsails/lspkind-nvim" , --auto completion icons
 "rcarriga/nvim-notify" , -- notification
-- "ms-jpq/coq_nvim",  --auto completion tool
-- "ms-jpq/coq.artifacts", -- 9000+ snippet
 "tpope/vim-sleuth" , --auto indent space detector
 "mfussenegger/nvim-dap" , --debugging support 
 "rcarriga/nvim-dap-ui" , --nvim-dap ui support
 "theHamsta/nvim-dap-virtual-text",
 "terrortylor/nvim-comment" , -- comment toggler
 "APZelos/blamer.nvim" , -- git blame
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
 --"vim-airline/vim-airline" , --status bar // causing some problem clipping the text, very annoying
 "lukas-reineke/indent-blankline.nvim" , --indent indicator
 "nvim-tree/nvim-web-devicons" , --colored icons
 "akinsho/bufferline.nvim" , --visual studio code styles tabs
 "ryanoasis/vim-devicons" , --icons
 "kyazdani42/nvim-tree.lua" , -- file explorer

 "nvim-lua/plenary.nvim" , -- don"t know what this it but needed for telescope
 "nvim-telescope/telescope.nvim" , -- fuzzy finder
 -- active window expander
 "anuvyklack/windows.nvim" ,
 "anuvyklack/middleclass",
 "anuvyklack/animation.nvim",
  {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
          require'alpha'.setup(require'alpha.themes.startify'.config)
      end
  },
  {
      "3rd/diagram.nvim", -- render mermaid diagrams in neovim
      dependencies = {
        "3rd/image.nvim"
      }
  }
})

EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set mouse=n "disable mouse
set clipboard+=unnamedplus
set path+=**                                    " Searches current directory recursively.
set updatetime=100
set hidden                      " Needed to keep multiple buffers open
set nobackup                    " No auto backups
set noswapfile                  " No swap
set number                      " line numbers
set relativenumber
set completeopt=menu,menuone,noselect
set laststatus=3                " global status bar
let mapleader=";"


set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" line swap keybindings
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-k> :m '<-2<CR>gv=gv 
vnoremap <A-j> :m '>+1<CR>gv=gv

" escape
inoremap <C-c> <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
" Make adjusing split sizes a bit more friendly
noremap <silent> <C-a> :vertical resize +3<CR>
noremap <silent> <C-d> :vertical resize -3<CR>
" noremap <silent> <C-w> :resize +3<CR>
" noremap <silent> <C-s> :resize -3<CR>

"treesitter (syntax hightlight) and color scheme configs 
" au BufNewFile,BufRead *.sol setfiletype solidity


noremap <silent> <leader>e :lua MiniFiles.open() <CR>
lua << EOF
require('mini.files').setup()
require('mini.indentscope').setup()
EOF

lua << EOF
    -- vim.notify = require("notify")
    -- vim.notify.setup(
    --   {
    --     fps = 5,
    --     render = "default",
    --     stages = "slide",
    --     timeout = 3000,
    --   }
    -- );
  require'windows'.setup({
    autowidth = {			--		       |windows.autowidth|
        winwidth = 1.4,			--		        |windows.winwidth|
       },
  })
    require'colorizer'.setup()

	require'nvim-treesitter.configs'.setup {
	  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
	  ensure_installed = { "c", "cpp", "go", "rust", "typescript", "javascript" },

	  -- Install parsers synchronously (only applied to `ensure_installed`)
	  sync_install = false,

	  -- Automatically install missing parsers when entering buffer
	  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	  auto_install = true,

	  highlight = {
	    enable = true,
	    use_languagetree = true,

	    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
	    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
	    -- the name of the parser)
	    -- list of language that will be disabled
	    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
	    disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
		    return true
		end
	    end,

	    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	    -- Using this option may slow down your editor, and you may see some duplicate highlights.
	    -- Instead of true it can also be a list of languages
	    additional_vim_regex_highlighting = false,
	  },
	}
EOF

" convert to lua copilot
set termguicolors 
syntax off
colorscheme vim
highlight Normal guibg=#00003f
highlight Pmenu guibg=#0300b3 guifg=#00FFFF
highlight PmenuSel guibg=#00FFFF guifg=#000000
highlight CursorLineNr guifg=#ffffff guibg=NONE
highlight LineNr guibg=NONE guifg=#a6a4a4
highlight WinSeparator guifg=#ffffff
highlight SignColumn guibg=NONE
highlight NonText guibg=none
""""""""""""""""""""
" git blame
""""""""""""""""""""
let g:blamer_enabled = 1
let g:blamer_relative_time = 1

"""""""""""""""""""""
" setup comment toggler
lua require('nvim_comment').setup()

" setup telescope
lua require('telescope').setup()
noremap <silent> <leader>lg :Telescope live_grep <CR>
noremap <silent> <leader>bf :Telescope current_buffer_fuzzy_find <CR>
noremap <silent> <leader>fi :Telescope find_files <CR>

" built in LSP keybindings and auto completion setup
" Turn this block into lua copilot
 " nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
 " nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
 " nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
 " nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
 " nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
 " nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>
 " nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_hlp()<CR>
 " nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
 " nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_prev()<CR>
 " nnoremap <silent> ca <cmd> :CodeActionMenu <CR>
""

lua << EOF
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--rename or replace rn
keymap('n', 'Rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<C-n>', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<C-p>', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set({ "v", "n" }, "ca", require("actions-preview").code_actions)
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
EOF

" coq and mason LSP STUFF
lua << EOF
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
      'ts_ls', 
      'clangd',
      'rust_analyzer',
      "lua_ls",
      'gopls',
    }
})
-- local lsp = require "lspconfig"
-- local coq = require "coq" 
-- lsp.tsserver.setup(coq.lsp_ensure_capabilities())
-- vim.cmd('COQnow -s')
EOF

"vscode style tabs (bufferline plugin) setup 
nnoremap <silent> <A-n> :BufferLineCycleNext <CR>
nnoremap <silent> <A-p> :BufferLineCyclePrev <CR>
lua << EOF
require("symbols-outline").setup()
require("bufferline").setup{
  options = {
      numbers = function(opts)
        return string.format('%s.%s', opts.id, opts.raise(opts.ordinal))
      end,
    show_buffer_close_icons = true,
    show_close_icon = true,
    tabsize = 25,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
	local sym = e == "error" and " "
	  or (e == "warning" and " " or " ")
	s = s .. n .. sym
      end
      return s
      end
  }
}
require("actions-preview").setup {
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}

EOF

lua << EOF
-- render mermaid in neovim for markdowns
require("image").setup({
  backend = "ueberzug",
  processor = "magick_cli", -- or "magick_cli"
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      floating_windows = false, -- if true, images will be rendered in floating markdown windows
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    neorg = {
      enabled = true,
      filetypes = { "norg" },
    },
    typst = {
      enabled = true,
      filetypes = { "typst" },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
  editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})
require("diagram").setup({
  integrations = {
    require("diagram.integrations.markdown"),
    require("diagram.integrations.neorg"),
  },
  renderer_options = {
    mermaid = {
      theme = "default",
    },
    plantuml = {
      charset = "utf-8",
    },
    d2 = {
      theme_id = 1,
    },
    gnuplot = {
      theme = "dark",
      size = "800,600",
    },
  },
})
require("lualine").setup{
  options = { theme = 'powerline_dark' } 
}
EOF

" source ~/.config/nvim/debugger.lua
source ~/.config/nvim/nvimCmp.lua
source ~/.config/nvim/splash.lua
