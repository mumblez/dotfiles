execute pathogen#infect()
filetype plugin indent on
syntax on
set hlsearch
set incsearch
set nocompatible             " Use Vim defaults (much better!)
set bs=indent,eol,start      " allow backspacing over everything in
set history=50               " keep 50 lines of command line history
set ruler                    " show the cursor position all the time
set cursorline               " highlight current line
set number                   " show line numbers
set mouse=a                  " allow click to move cursor and select


"== indentation - prefer spaces =="
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"== easier indentation =="
vnoremap < <gv
vnoremap > >gv

"== show column boundary =="
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"== Make tabs, trailing whitespace, and non-breaking spaces visible =="
exec "set listchars=eol:¬,trail:.,nbsp:~,tab:»·"
set nolist

"== better digraphs =="
set enc=utf-8
"inoremap <expr>  <C-K>   BDG_GetDigraph()

"== auto reload .vimrc on save =="
autocmd! bufwritepost .vimrc source %

"== Script configs =="
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

"== Load custom settings =="
"source ~/.vim/startup/color.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/yaml.vim
