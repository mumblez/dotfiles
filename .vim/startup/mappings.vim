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

"== quite without saving
nnoremap <leader>q :q!<cr>

"== add blank lines above and below current line
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j

"== Fn Toggles =="
map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>

"== Golang run =="
map <F5> :GoRun %<CR>

"== cleanup lines over 80 chars =="
let @a = '080lBi'
nnoremap <leader>a @a

"== buffer switching
"next buffer
nnoremap <leader>b :bn<CR>
"previous buffer
nnoremap <leader>B :bp<CR>

" example of creating a custom snippet
"nnoremap ,html :-1read /Users/yusuf/goworkspace/src/yt/experiments/bitwise/hello.txt<CR>5jwi
