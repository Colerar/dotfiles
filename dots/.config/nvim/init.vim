call plug#begin('~/.config/nvim/plugged')
  Plug 'SirVer/ultisnips'
  Plug 'rakr/vim-one'
  Plug 'honza/vim-snippets'
  Plug 'scrooloose/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'mhinz/vim-startify'
  Plug 'vim-airline/vim-airline'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set nocompatible
set showmatch
set ignorecase
set mouse=v
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
set wildmode=longest,list
set cc=120
filetype plugin indent on
syntax on
set mouse=a
set clipboard=unnamedplus
filetype plugin on
set cursorline
set directory=$HOME/.config/.nvim/swapfiles//

" Use true-color mode
if ($TERMINAL_EMULATOR != "JetBrains-JediTerm" && $COLORTERM == "truecolor" && empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

if ($TERMINAL_EMULATOR != "JetBrains-JediTerm" && $LC_TERMINAL == "iTerm2" || $TERM_PROGRAM == "WezTerm")
  colorscheme one
  set background=light
  let g:airline_theme='one'
endif
