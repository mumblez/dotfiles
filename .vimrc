execute pathogen#infect()
filetype plugin indent on
syntax on
set hlsearch
set incsearch
set ignorecase
set smartcase                " case insensitive search unless capital used
set nocompatible             " Use Vim defaults (much better!)
set bs=indent,eol,start      " allow backspacing over everything in
set history=50               " keep 50 lines of command line history
set ruler                    " show the cursor position all the time
"set cursorline               " highlight current line
set number                   " show line numbers
set mouse=a                  " allow click to move cursor and select
"set relativenumber number
set laststatus=2             " required for airline
set splitright               " vsplit to the right
set splitbelow               " split below
autocmd BufRead,BufNewFile *.txt,*.md set complete+=kspell   " add spell checking words to word completion (ctrl+p)
" autocmd BufRead,BufNewFile   *.txt,*.md set spell " turn on spell checking for text files

"== indentation - prefer spaces =="
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"== correct yaml indentation
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

"== change to directory of file on enter (for each buffer)
"helps with tmux so we can open a split and run terraform or such!
autocmd BufEnter * silent! lcd %:p:h

"set completeopt-=preview

"== finding files
set path+=**
set wildmenu "display matching files for tab complete

"== file browsing / autocomplete for commands shown in wildmenu
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"== easier indentation =="
vnoremap < <gv
vnoremap > >gv

"== show column boundary =="
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"== Change popup autocomplete background"
"highlight Pmenu ctermbg=red ctermfg=white

"== Make tabs, trailing whitespace, and non-breaking spaces visible =="
" exec "set listchars=eol:¬,trail:.,nbsp:~,tab:»·"
" set nolist

"== better digraphs =="
set enc=utf-8
"inoremap <expr>  <C-K>   BDG_GetDigraph()

"== auto reload .vimrc on save =="
autocmd! bufwritepost .vimrc source %

"== Script configs =="
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

"== Load custom settings =="
source ~/.vim/startup/color.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
" autocmd FileType go source ~/.vim/startup/golang.vim
source ~/.vim/startup/golang.vim
source ~/.vim/startup/python.vim
source ~/.vim/startup/airline.vim
source ~/.vim/startup/ctrlp.vim
source ~/.vim/startup/terraform.vim

set rtp+=~/.fzf

