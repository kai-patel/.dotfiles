let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
scriptencoding utf-8

" Allow mouse to resize splits (if terminal handles drag events)
set mouse=n

" Set leader
let mapleader="#"
let maplocalleader='z'

" Buffer switching
nnoremap <silent> <leader><leader> <C-^>

" Colour Scheme
colorscheme slate " (dark scheme)
" colorscheme default

" Ensure colorscheme accuracy
set t_Co=256

" Subfolder searching (can be slow)
:set path+=**

" Set colorcolumn
set colorcolumn=

" Row numbers
set number
set cursorline
set relativenumber

" Show whitespace
set list
set listchars=tab:→\ ,trail:•,extends:#,nbsp:.

" Show commands, enable menu
set showcmd
set wildmenu

" Only draw when needed
set lazyredraw

" Highlight matching braces
set showmatch

" No highlight searches, incremental search
set incsearch
set nohlsearch

" Smart casing
set ignorecase
set smartcase

" Tabs over spaces
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

" Proper backspacing
set backspace=indent,eol,start

" Set utf-8 compatibility
set encoding=utf-8

" Enable splitting directions
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Moving between split windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" Toggle folds
nnoremap <space> za

" Enable syntax completion
filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
syntax enable

" Sort completions by descending length
" set completeopt+=longest

" Always show the autocompelete window when completing
" set completeopt+=menuone

" Enable preview info for autocompletion
" set completeopt+=preview

nnoremap j gj
nnoremap gj j

nnoremap k gk
nnoremap gk k

" Turn off errorbell for Esc in Normal mode
set belloff=esc

" Limit max displayed popup menu items
set pumheight=10

" Always show mode
set showmode

" Statusline Config
set laststatus=2
set statusline=

" Use white on dark gray
set statusline+=%1*

" File name
set statusline+=\ %t\ 

" Use black on light gray
set statusline+=%2*

" File type
set statusline+=\ 
set statusline+=%y

" Current Character Value [dec, hex]
set statusline+=\ [%b,\ %B]

" Lines
set statusline+=\ %LL

" Git branch
set statusline+=\ 
set statusline+=%{FugitiveStatusline()}

" Modified flag
set statusline+=\ 
set statusline+=%m


" Switch to right-hand side
set statusline+=%=

" Use white on black
set statusline+=%3*

" Cursor Position [row, col]
set statusline+=\ [%l,%c]

" Percentage through file
set statusline+=\ %p%%\ 

" Statusline colours

hi User1 ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
hi User2 ctermbg=lightgray ctermfg=black guibg=lightgray guifg=black
hi User3 ctermbg=black ctermfg=white guibg=black guifg=white

set ttimeout ttimeoutlen=50

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'lewis6991/gitsigns.nvim', { 'tag': 'v1.0.2' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'p00f/clangd_extensions.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'utilyre/sentiment.nvim'
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'junegunn/vim-easy-align'
Plug 'lark-parser/vim-lark-syntax'
Plug 'pprovost/vim-ps1'
Plug 'vimwiki/vimwiki'
Plug 'stevearc/oil.nvim'
Plug 'Saghen/blink.cmp', { 'tag': 'v1.3.1' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/lazydev.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'
Plug 'github/copilot.vim'
call plug#end()

" Editorconfig Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Commentary
autocmd FileType cpp setlocal commentstring=//\ %s

" Yank from WSL to Windows
nnoremap <silent> <leader>w :w !clip.exe<CR>
vnoremap <silent> <leader>w :'<,'> w !clip.exe<CR>

" vlime
let g:vlime_compiler_policy = {"DEBUG": 3}
let g:vlime_enable_autodoc = v:true

" vim-easy-align
xmap ga <Plug>(EasyAlign)

let g:copilot_node_command = 'node'
