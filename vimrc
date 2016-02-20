" New default vimrc
"
" - Sami 2016-02-19
"
au!

if has("win32")
  let g:vimrc=$HOME . '/_vimrc'
  let g:vimdir=$HOME . '/_vim'
else
  let g:vimrc=$HOME . '/.vimrc'
  let g:vimdir=$HOME . '/.vim'
endif

"------------------------------
" Vundle setup
"------------------------------
if !has("win32")
        set nocompatible              " be iMproved, required
        filetype off                  " required

        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()

        Plugin 'gmarik/Vundle.vim'
        Plugin 'tpope/vim-fugitive'
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'mhinz/vim-signify'
        Bundle 'vim-scripts/VimClojure'
        Bundle 'neilagabriel/vim-geeknote'
        Bundle 'scrooloose/nerdtree'

        call vundle#end()            " required
        filetype plugin indent on    " required
endif

" Colours
colorscheme desert " the best

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:GeeknoteFormat="markdown"

" Clojure stuff
" Nailgun does not work properly right now
"let vimclojure#WantNailgun=1


if has("gui_running")
  "GUI settings
  colorscheme desert
  set go=m "Hide the icons
  if has("win32")
    "WIN32 GUI settings
    set guifont=Consolas:h9:cANSI
    behave mswin "Windows-specific UI-behaviour for selections etc.
  else
    set guifont=monospace\ 8
  endif
else
  "Console settings
  set background=light "Adapt for white terminal
  highlight LineNr term=bold ctermfg=white ctermbg=blue
  highlight Statement ctermfg=darkred
  highlight Comment ctermfg=darkgreen
  highlight Type ctermfg=blue
endif

" Basic setup
syntax enable

set bs=2 "Backspace works like backspace, needed for gvim on Windows at least
set tabstop=2
set softtabstop=2
set expandtab

" Reselect after indent
vnoremap < <gv
vnoremap > >gv

set number " show line numbers
set showcmd

set wildmenu "Graphical autocomplete menu

set lazyredraw
set showmatch

" Searching
set incsearch " Search while entering characters
set hlsearch  " Hilight results

" Move by visual lines not linenumers
nnoremap j gj
nnoremap k gk

" Add geeknote shortcut
noremap <F8> :Geeknote<cr>

inoremap jk <esc>

autocmd vimenter * NERDTree

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" ---------------------------
" Airline
" ---------------------------
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 1

let g:airline_theme = 'bubblegum'

fun! AirlineInit()
  let g:airline_section_b = airline#section#create_left(['branch'])
  let g:airline_section_x = airline#section#create_left(['hunks'])
endfun
autocmd VimEnter * call AirlineInit()

" --------------------------
" Support snippets
" --------------------------

augroup myvimrc
        if has("win32")
            autocmd! BufWritePost _vimrc silent! source ~/_vimrc
        else
            au!
            au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
        endif
augroup END
