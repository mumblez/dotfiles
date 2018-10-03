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

"== add blank lines above and below current line.
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
"nnoremap <F8> :TagbarOpenAutoClose<CR>
nnoremap <F8> :TagbarToggle<CR>

"== fzf shortcuts
nnoremap \g :GFiles <CR>
nnoremap \l :Locate 

nnoremap \b :bd <CR>
nnoremap \j :lcd %:p:h<CR>:pwd<CR>

"== sessions
let g:session_directory = "~/.cache/vim-sessions"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession 
nnoremap <leader>ss :SaveSession 
nnoremap <leader>sd :DeleteSession 
nnoremap <leader>sc :CloseSession<CR>

"== git / fugitive
nnoremap <leader>g :Gstatus<cr>
" inside status window
" C-n - next file
" C-p - prev file
" -   - stage / unstage file
" cc  - commit
" dv  - vertical diff split
" q   - quit status
" r   - reload

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

"== QUICKFIX window navigation
" cycle when we hit end / beginning
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
nnoremap <silent> <C-Down> :Cnext<CR>
nnoremap <silent> <C-Up> :Cprev<CR>
"== will close quickfix window if all last window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END


" example of creating a custom snippet
" nnoremap ,html :-1read ~/goworkspace/src/yt/experiments/bitwise/hello.txt<CR>5jwi
"
" Quick folding toggle
nnoremap <space> za
set foldmethod=manual
set foldlevel=99

"== save read-only file
cmap w!! w !sudo tee > /dev/null %

