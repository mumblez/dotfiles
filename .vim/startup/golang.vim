" we want to tell the syntastic module when to run
" we want to see code highlighting and checks when  we open a file
" but we don't care so much that it reruns when we close the file
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

" add closing brackets / quotes
" inoremap {<CR> {<CR>}<Esc>O
" inoremap { {}<esc>i
" inoremap [ []<esc>i
" inoremap ( ()<esc>i
" inoremap ' ''<esc>i
" inoremap " ""<esc>i
" inoremap ` ``<esc>i
" " jump over auto closed item (as long as we're not at the end
" inoremap <c-l> <esc>la
" inoremap <c-j> <esc>o

" auto write file so we can test and build without saving first
"autocmd FileType go set autowrite
set autowrite
" only use quickfix window
let g:go_list_type = "quickfix"

" we also want to get rid of accidental trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" tell vim to allow you to copy between files, remember your cursor
" position and other little nice things like that
set viminfo='100,\"2500,:200,%,n~/.viminfo

" set scratch preview window below
"set splitbelow
augroup PreviewOnBottom
  autocmd InsertEnter * set splitbelow
  autocmd InsertLeave * set splitbelow!
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

" use goimports for formatting
let g:go_fmt_command = "goimports"
"let g:go_fmt_command = "goreturns"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info = 1
set updatetime=3000

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1

" let g:syntastic_go_checkers = ['go', 'golint', 'errcheck', 'govet', 'gofmt']
"let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
"nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>
au FileType go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au FileType go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au FileType go nnoremap <leader>r :exe "GoRun %"<CR>
au FileType go nnoremap <leader>t :exe "GoTest"<CR>
au FileType go nnoremap <leader>b :exe "GoBuild"<CR>
au FileType go nnoremap <leader>i :exe "GoInfo"<CR>
au FileType go nnoremap <leader>d :exe "GoDoc"<CR>
au FileType go nnoremap \t :exe "GoTestFunc"<CR>
" nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
" nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
" nnoremap <leader>r :exe "GoRun %"<CR>
" nnoremap <leader>t :exe "GoTest"<CR>
" nnoremap <leader>b :exe "GoBuild"<CR>
" nnoremap <leader>i :exe "GoInfo"<CR>
" nnoremap <leader>d :exe "GoDoc"<CR>
" nnoremap \t :exe "GoTestFunc"<CR>

" enable ultisnips but use different selection to not conflict with
" YouCompleteMe
" let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
