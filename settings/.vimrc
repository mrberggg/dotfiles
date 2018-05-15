" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

syntax enable

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

let need_to_install_plugins=0
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamed

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","

" =============== Vundle Initialization ===============
" Bootstrap Vundle if it's not installed
if empty(system("grep lazy_load ~/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
    silent !mkdir -p ~/.vim/bundle
    silent !rm -rf ~/.vim/bundle/Vundle.vim
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
    let need_to_install_plugins=1
endif

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'w0rp/ale'                          " alternative to syntastic
Plugin 'vim-syntastic/syntastic'
Plugin 'DataWraith/auto_mkdir'             " Allows you to save files into directories that do not exist yet
Plugin 'ctrlpvim/ctrlp.vim'                " Quick open files
Plugin 'tomasr/molokai'                    " Monokai theme
Plugin 'scrooloose/nerdcommenter'          " quickly (un)comment lines
Plugin 'scrooloose/nerdtree'               " 
Plugin 'ervandew/supertab'                 " Perform all your vim insert mode completions with Tab
Plugin 'godlygeek/tabular'                 " 
Plugin 'vim-airline/vim-airline'           " more informative status/tabline
Plugin 'vim-airline/vim-airline-themes'    " airline styling
Plugin 'tpope/vim-dispatch'
Plugin 'airblade/vim-gitgutter'            " shows a git diff in the gutter (sign column) and stages/reverts hunks
Plugin 'tpope/vim-repeat'                  " Enable repeating supported plugin maps with .
Plugin 'tpope/vim-surround'                " makes working w/ quotes, braces,etc. easier

" Syntaxes
Plugin 'mattn/emmet-vim'                   " 
Plugin 'plasticboy/vim-markdown'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Bundle 'OmniSharp/omnisharp-vim' "Requires vim8 or neovim

" All of your Plugins must be added before the following line
call vundle#end()            " required

"#############################################################################
" Plugin configuration
"#############################################################################
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Set colorscheme
" Go to https://github.com/roosta/vim-srcery/ for color palette

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set backspace=indent,eol,start "Allow backspacing over autoindent, line breaks, and start of insert action
set mouse=a         " Allow mouse

" ================ Maps ===========================

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>nt :NERDTree<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>wl <C-w>l<CR>
nnoremap <leader>wr <C-w>h<CR>
nnoremap <leader>wL <C-w>H<CR>
nnoremap <leader>wR <C-w>L<CR>
"indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv
" Comment/uncomment lines
map <leader>/ <plug>NERDCommenterToggle
