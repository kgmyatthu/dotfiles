" termguicolors must be set before lazy.setup so plugins (eg colorizer) that
" assert on it in their config() see the right value.
set termguicolors

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
  { import = "plugins" },
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

" mini.files
noremap <silent> <leader>e :lua MiniFiles.open() <CR>

" convert to lua copilot
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

" telescope keymaps
noremap <silent> <leader>lg :Telescope live_grep <CR>
noremap <silent> <leader>bf :Telescope current_buffer_fuzzy_find <CR>
noremap <silent> <leader>fi :Telescope find_files <CR>

" built in LSP keybindings
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
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
EOF

" bufferline keymaps
nnoremap <silent> <A-n> :BufferLineCycleNext <CR>
nnoremap <silent> <A-p> :BufferLineCyclePrev <CR>

" FTerm keymaps
lua << EOF
vim.keymap.set('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
EOF

" source ~/.config/nvim/debugger.lua
source ~/.config/nvim/nvimCmp.lua
source ~/.config/nvim/splash.lua
