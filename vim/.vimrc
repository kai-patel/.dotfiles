" VIM CONFIG

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
set background=dark

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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Toggle folds
nnoremap <space> za

" Enable syntax completion
filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
syntax enable

" Sort completions by descending length
set completeopt+=longest

" Always show the autocompelete window when completing
set completeopt+=menuone

" Enable preview info for autocompletion
set completeopt+=preview

" Filetype-specific commands for each time a file is saved
"augroup python_settings " {
"    autocmd!
"    autocmd FileType python compiler pylint
"    autocmd BufWritePost *.py :make %
"augroup END " }

" Some settings for muComplete plugin
set completeopt+=noinsert   " alternatively use: set completeopt+=noselect

" Recommended settings for muComplete plugin
"set shortmess+=c "disable completion messages
"set belloff+=ctrlg "if bell rings during completion
"let g:mucomplete#enable_auto_at_startup = 1 "enable on startup

" muComplete popup delay
"let g:mucomplete#completion_delay = 1

" Swap g(j/k) and j/k for easier editing
nnoremap j gj
nnoremap gj j

nnoremap k gk
nnoremap gk k

" Set shell zsh
"set shell=zsh

" Rebind exiting of in-built terminal emulator
" tnoremap <Esc> <C-\><C-n>:bd!<CR>

" << Smart >> tab to autocomplete

" function! Smart_TabComplete()
"     let line = getline('.')

"     let substr = strpart(line, -1, col('.')+1)


"     let substr = matchstr(substr, "[^ \t]*$")
"     if (strlen(substr)==0)
"         return "\<tab>"
"     endif
"     let has_period = match(substr, '\.') != -1
"     let has_slash = match(substr, '\/') != -1
"     if (!has_period && !has_slash)
"         return "\<C-X>\<C-P>"
"     elseif ( has_slash )
"         return "\<C-X>\<C-F>"
"     else
"         return "\<C-X>\<C-O>"
"     endif
" endfunction

" The actual binding for the above
"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

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

" Neovim Python Provider
" let g:python3_host_prog = 'python'

let c='A'
while c <= 'Z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set ttimeout ttimeoutlen=50


" PLUGINS
" -------

" Install vim-plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Turn on/off ALE
" let g:ale_enabled = 0

" Make ALE and CoC work together (must occur before plugin loading)
" let g:ale_disable_lsp = 1

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
" Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ervandew/supertab' Don't use with coc (messes up TAB to complete)
Plug 'tpope/vim-commentary'
" Plug 'rust-lang/rust.vim'
" Plug 'pantharshit00/vim-prisma'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'dhruvasagar/vim-dotoo'
Plug 'OmniSharp/omnisharp-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'DingDean/wgsl.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'wilmhub/vlime', {'rtp': 'vim/'}
" Plug 'evanleck/vim-svelte'
" Plug 'kovisoft/slimv'
" Plug 'vimwiki/vimwiki'
" Plug 'mattn/calendar-vim'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" VLIME Config
" let g:vlime_cl_impl = "ros"
" function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
"     return ["ros", "run",
"                 \ "--load", a:vlime_loader,
"                 \ "--eval", a:vlime_eval]
" endfunction

" SLIMV Config
" let g:slimv_leader='z'
" let g:slimv_lisp = "ros run"
" let g:slimv_impl = 'sbcl'
" let g:slimv_swank_cmd = '!ros run -l "~/.vim/plugged/slimv/slime/start-swank.lisp"'

" Disable SLIMV (e.g. when both SLIMV and VLIME are installed)
" let g:slimv_disable_lisp = 1

" FZF Config
nnoremap <leader>f :Files<CR>

" ALE Config

" let g:ale_linters = {'rust': ['analyzer'], 'typescriptreact': ['eslint', 'prettier'], 'cs': ['OmniSharp']}
" let g:ale_echo_msg_format = '%linter% -- %s'
" let g:ale_fixers = {'typescriptreact': ['prettier'], 'python': ['black'], 'rust': ['rustfmt'], 'haskell': ['brittany'], 'json': ['prettier'], 'c': ['clang-format'], 'cpp': ['clang-format'], 'markdown': ['prettier']}

" nnoremap <S-A-F> :ALEFix<CR>
" nnoremap g[ :ALEPrevious<CR>
" nnoremap g] :ALENext<CR>

autocmd FileType cs nmap <silent> <buffer> <S-A-F> <Plug>(omnisharp_code_format)

" Coc Config
set updatetime=300 " Default 4000 (ms)
set signcolumn=yes
let g:coc_global_extensions = ['coc-rust-analyzer', '@yaegassy/coc-tailwindcss3', 'coc-tsserver', 'coc-clangd', 'coc-prisma', 'coc-json', 'coc-omnisharp']

nnoremap <S-A-F> :call CocActionAsync("format")<CR>

" Redefine <TAB> for coc autocompletion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" Symbol renaming
nmap <leader>r <Plug>(coc-rename)

" Remap keys for applying refactor code actions
nmap <silent> <leader>c <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>c <Plug>(coc-codeaction-refactor-selected)

" Go to definition per LSP
nmap <silent> <leader>g <Plug>(coc-definition)

" Go to impl
nmap <silent> <leader>I <Plug>(coc-implementation)

" Get references
nmap <silent> <leader>i <Plug>(coc-references)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')


" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>

" Find symbols of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

" coc-clangd
nnoremap <silent><nowait> <leader>s :CocCommand clangd.switchSourceHeader<cr>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-line)

" NERDTree Config
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

" let NERDTreeIgnore=[]

" Toggle NERDTree
nnoremap <silent> <C-_> :NERDTreeToggle<CR>


" Vimwiki Config
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'auto_diary_index': 1}]

" Editorconfig Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Commentary
autocmd FileType cpp setlocal commentstring=//\ %s
