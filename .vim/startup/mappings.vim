"== set our leader key =="
let mapleader = ","

"== more sane highlight search =="
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

"== toggle highlighted search =="
nnoremap <leader>h :nohlsearch<CR>

"== navigate between windows easier, also doesn't conflict with iterm which
"   closes the terminal tab "
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"== quit without saving
nnoremap <leader>q :quit<cr>
nnoremap <leader>Q :qa!<cr>

"== add blank lines above and below current line
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j

"====== Fn Toggles / mappings ========"
map <F2> :NERDTreeToggle<CR>
"set pastetoggle=<F3>
nnoremap <F3> :set number!<CR>
nnoremap <F4> :set spell!<CR>
nnoremap <F5> :set ft=sh<CR>
"== copy and paste shortcuts into system clipboard
" can use '+' or '*'
vnoremap <F6> "*y
nnoremap <F7> "*p
"== fzf shortcuts
nnoremap \g :GFiles <CR>
nnoremap \l :Locate <CR>

nnoremap \b :bd <CR>

"== Golang run =="
"map <F5> :GoRun %<CR>

"== cleanup lines over 80 chars =="
let @a = '080lBi'
nnoremap <leader>a @a

"== buffer switching
"next buffer
nnoremap <C-n> :bnext<CR>
"previous buffer
nnoremap <C-p> :bprevious<CR>

"== quickfix list (backwards and forwards through list)
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>
nnoremap <leader>cl :clist<CR>
nnoremap <leader>ccl :cclose<CR>

" example of creating a custom snippet
"nnoremap ,html :-1read /Users/yusuf/goworkspace/src/yt/experiments/bitwise/hello.txt<CR>5jwi
"
" Quick folding toggle
nnoremap <space> za
set foldmethod=indent
set foldlevel=99

"== save read-only file
cmap w!! w !sudo tee > /dev/null %

