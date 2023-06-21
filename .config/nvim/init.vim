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
 "zbirenbaum/copilot.lua" , -- github copilot
 "nvim-treesitter/nvim-treesitter" , --syntax hightlight 
 "p00f/nvim-ts-rainbow" , -- bracket colorizer
 "NvChad/nvim-colorizer.lua" , --color preview
 "Abstract-IDE/Abstract-cs" , -- color theme
 "fenetikm/falcon" , -- colorscheme
 "dasupradyumna/midnight.nvim" , --colorscheme
 "tiagovla/tokyodark.nvim" , --colorscheme
 "RRethy/nvim-base16" , -- colorscheme
 "rktjmp/lush.nvim" , --arctic"s dep
 "rockyzhang24/arctic.nvim" , -- colorscheme
 "sunjon/shade.nvim" , --inactive window dimmer
 -- Language server and auto completion plugins
 "neovim/nvim-lspconfig" , -- built-in LSP
 "williamboman/mason.nvim" , --Easily install and manage LSP servers, DAP servers, linters, and formatters.
 "williamboman/mason-lspconfig.nvim" , --LSP installer
--  "williamboman/nvim-lsp-installer" , -- language server auto installer
 "hrsh7th/cmp-nvim-lsp" , --auto completion suite
 "hrsh7th/cmp-buffer",
 "hrsh7th/cmp-path",
 "hrsh7th/cmp-cmdline",
 "hrsh7th/nvim-cmp",
 "onsails/lspkind-nvim" , --auto completion icons
 "rcarriga/nvim-notify" , -- notification
 --  "ms-jpq/coq_nvim", {"branch": "coq"} , --auto completion tool
 --  "ms-jpq/coq.artifacts", {"branch": "artifacts"} , -- 9000+ snippet
 "weilbith/nvim-code-action-menu" , --codeaction menu
 "tpope/vim-sleuth" , --auto indent space detector
 "mfussenegger/nvim-dap" , --debugging support 
 "rcarriga/nvim-dap-ui" , --nvim-dap ui support
 "theHamsta/nvim-dap-virtual-text",
 "terrortylor/nvim-comment" , -- comment toggler
 "tpope/vim-fugitive" , --git commands in neovim
 "APZelos/blamer.nvim" , -- git blame
 "vim-airline/vim-airline" , --status bar
 "lukas-reineke/indent-blankline.nvim" , --indent indicator
 "kyazdani42/nvim-web-devicons" , --colored icons
 "akinsho/bufferline.nvim" , --visual studio code styles tabs
 "ryanoasis/vim-devicons" , --icons
 "kyazdani42/nvim-tree.lua" , -- file explorer

 "nvim-lua/plenary.nvim" , -- don"t know what this it but needed for telescope
 "nvim-telescope/telescope.nvim" , -- fuzzy finder
 "nvim-telescope/telescope-media-files.nvim" , -- media preview for telescope
 "danilamihailov/beacon.nvim", -- cursor tracker
 -- active window expander
 "anuvyklack/windows.nvim" ,
 "anuvyklack/middleclass",
 "anuvyklack/animation.nvim",

 "folke/which-key.nvim",-- show keybindings
})

EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=n "disable mouse
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
au BufNewFile,BufRead *.sol setfiletype solidity

lua << EOF
    vim.notify = require("notify")
    vim.notify.setup(
      {
        fps = 20,
        render = "default",
        stages = "slide",
        timeout = 3000,
      }
    );
  require'windows'.setup({
    autowidth = {			--		       |windows.autowidth|
        winwidth = 1.4,			--		        |windows.winwidth|
       },
  })
    require'colorizer'.setup()

  require'nvim-treesitter.configs'.setup {
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = function(lang, bufnr) 
        return vim.api.nvim_buf_line_count(bufnr) > 1000
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

  require("indent_blankline").setup {
      -- for example, context is off by default, use this to turn it on
      show_current_context = true,
      show_current_context_start = true,
  }

EOF

set termguicolors 
syntax on
colorscheme darkblue
highlight Pmenu guibg=#0300b3 guifg=#00FFFF
highlight PmenuSel guibg=#00FFFF guifg=#000000
highlight LineNr guibg=none guifg=#ffffff
highlight WinSeparator guifg=#ffffff
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
local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}
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
      'csharp_ls',
      'omnisharp_mono',
      'rust_analyzer'
    }
})

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
      formatting = {
        format = function(entry, vim_item)
            -- From kind_icons array
            vim_item.kind = string.format('%s %s', cmp_kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
                  latex_symbols = "[LaTeX]",
                })[entry.source.name]
            return vim_item
        end
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    
    window = {
        completion = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:None,CursorLine:Visual,Search:None",
        },
        documentation = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:Normal,CursorLine:Visual,Search:None",
        },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-]>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['eslint'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['bashls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['jdtls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['omnisharp'].setup {
    capabilities = capabilities,
    cmd = { "omnisharp-mono", '--languageserver' , '--hostPID', tostring(vim.fn.getpid()) },
  }

--      'tsserver', 
--      'eslint', 
--      'cssls',
--      'vimls',
--      'clangd',
--      'pyright',
--      'pylsp',
--      'omnisharp_mono',
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
source ~/.config/nvim/copilot.vim

