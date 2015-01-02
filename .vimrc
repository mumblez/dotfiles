execute pathogen#infect()
filetype plugin indent on
syntax on
set hlsearch
set nocompatible             " Use Vim defaults (much better!)
set bs=indent,eol,start         " allow backspacing over everything in
set history=50              " keep 50 lines of command line history
set ruler                    " show the cursor position all the time
"== Set tabbing to a more reasonable 4 spaces but keep as space instead of tab"
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number " show line numbers

"== set look and feel =="
set background=dark
colorscheme solarized

"== show column boundary =="
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"== more sane highlight search =="
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>
" just highlight the match in red...
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

"== better digraphs =="
"inoremap <expr>  <C-K>   BDG_GetDigraph()
