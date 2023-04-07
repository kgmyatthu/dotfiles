call plug#begin('~/.config/nvim/plugins')
Plug 'github/copilot.vim' "ai pair code

Plug 'nvim-treesitter/nvim-treesitter' "syntax hightlight 
Plug 'p00f/nvim-ts-rainbow' " bracket colorizer
Plug 'shaeinst/roshnivim-cs' "color theme
Plug 'ray-x/starry.nvim'      " color theme
Plug 'NvChad/nvim-colorizer.lua' "color preview

Plug 'sunjon/shade.nvim' "inactive window dimmer
" Language server and auto completion plugins
Plug 'neovim/nvim-lspconfig' " built-in LSP
Plug 'williamboman/mason.nvim' "Easily install and manage LSP servers, DAP servers, linters, and formatters.
Plug 'williamboman/mason-lspconfig.nvim' "LSP installer
" Plug 'williamboman/nvim-lsp-installer' " language server auto installer
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} "auto completion tool
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " 9000+ snippet
Plug 'weilbith/nvim-code-action-menu' "codeaction menu
Plug 'tpope/vim-sleuth' "auto indent space detector
Plug 'liuchengxu/vista.vim' "code structure outline shower
Plug 'echasnovski/mini.nvim' "mini map

Plug 'mfussenegger/nvim-dap' "debugging support 
Plug 'rcarriga/nvim-dap-ui' "nvim-dap ui support
Plug 'theHamsta/nvim-dap-virtual-text'

Plug 'terrortylor/nvim-comment' " comment toggler

Plug 'tpope/vim-fugitive' "git commands in neovim
Plug 'APZelos/blamer.nvim' " git blame
Plug 'sindrets/diffview.nvim'

Plug 'vim-airline/vim-airline' "status bar

Plug 'lukas-reineke/indent-blankline.nvim' "indent indicator
Plug 'kyazdani42/nvim-web-devicons' "colored icons

Plug 'akinsho/bufferline.nvim' "visual studio code styles tabs
Plug 'ryanoasis/vim-devicons' "icons

Plug 'kyazdani42/nvim-tree.lua' " file explorer

Plug 'nvim-lua/plenary.nvim' " don't know what this it but needed for telescope
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder
Plug 'nvim-telescope/telescope-media-files.nvim' " media preview for telescope

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' } "markdown-preview
Plug 'ellisonleao/glow.nvim' " markdown preview

Plug 'danilamihailov/beacon.nvim'" cursor tracker

" active window expander
Plug 'anuvyklack/windows.nvim' 
Plug 'anuvyklack/middleclass'
Plug 'anuvyklack/animation.nvim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse= "disable mouse
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
" inoremap ;; <Esc>

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
au BufNewFile,BufRead *.sol setfiletype solidity
lua << EOF
  require'windows'.setup({
    autowidth = {			--		       |windows.autowidth|
        winwidth = 1.4,			--		        |windows.winwidth|
       },
  })
    require'colorizer'.setup()
  -- require('shade').setup()
  -- mminimap for code
  local MiniMap = require('mini.map')
  require('mini.map').setup({
      -- Highlight integrations (none by default)
      integrations = {
        MiniMap.gen_integration.builtin_search(),
        MiniMap.gen_integration.gitsigns(),
      },

      -- Symbols used to display data
      symbols = {
        -- Encode symbols. See `:h MiniMap.config` for specification and
        -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
        -- Default: solid blocks with 3x2 resolution.
        encode = MiniMap.gen_encode_symbols.shade('2x1'),

        -- Scrollbar parts for view and line. Use empty string to disable any.
        scroll_line = '█',
        scroll_view = '┃',
      },
  })
  vim.keymap.set('n', '<Leader>ma', function()
    MiniMap.toggle()
  end)

  require'nvim-treesitter.configs'.setup {
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = function(lang, bufnr) 
        return vim.api.nvim_buf_line_count(bufnr) > 2000
      end,
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      }
  }  
EOF

set termguicolors 
syntax on
colorscheme darkblue
" highlight Pmenu guibg=#0300b3 guifg=#00FFFF
" highlight PmenuSel guibg=#00FFFF guifg=#000000
" highlight Normal guibg=none
" highlight NonText guibg=none
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
noremap <silent> <leader>li :Telescope live_grep <CR>
" noremap <silent> ff :Telescope current_buffer_fuzzy_find <CR>

" airline (status bar) git branch display
" let g:airline#extensions#branch#enabled = 1

" built in LSP keybindings and auto completion setup
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_hlp()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ca <cmd> :CodeActionMenu <CR>

lua << EOF
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
      'tsserver', 
      'eslint', 
      'cssls',
      'vimls',
      'clangd',
      'pyright',
      'pylsp',
    }
})

local lsp = require "lspconfig"
local coq = require "coq" 

lsp.tsserver.setup(coq.lsp_ensure_capabilities())
lsp.eslint.setup(coq.lsp_ensure_capabilities())
lsp.cssls.setup(coq.lsp_ensure_capabilities())
lsp.vimls.setup(coq.lsp_ensure_capabilities())
lsp.clangd.setup(coq.lsp_ensure_capabilities())

lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.pylsp.setup(coq.lsp_ensure_capabilities())
lsp.vuels.setup(coq.lsp_ensure_capabilities())
lsp.volar.setup(coq.lsp_ensure_capabilities())
vim.cmd('COQnow -s')
EOF

"vscode style tabs (bufferline plugin) setup 
nnoremap <silent> <A-n> :BufferLineCycleNext <CR>
nnoremap <silent> <A-p> :BufferLineCyclePrev <CR>
lua << EOF
require("bufferline").setup{
    options = {
          numbers = function(opts)
            return string.format('%s.%s', opts.id, opts.raise(opts.ordinal))
          end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        tabsize = 25,
        offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "center"
                    }
                    },
        diagnostics = "nvim_lsp"
    }
}
EOF

" file explorer (nvim-tree) setup
noremap <silent> <A-e> :NvimTreeToggle <CR>
lua << EOF
-- following options are the default
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = true,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when you run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- Hide the root path of the current folder on top of the tree 
    hide_root_folder = false,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}
EOF
source ~/.config/nvim/debugger.vim
source ~/.config/nvim/vistaConfig.vim
