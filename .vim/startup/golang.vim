" we want to tell the syntastic module when to run
" we want to see code highlighting and checks when  we open a file
" but we don't care so much that it reruns when we close the file
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" auto write file so we can test and build without saving first
autocmd FileType go set autowrite
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
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1

"let g:syntastic_go_checkers = ['go', 'golint', 'errcheck', 'govet', 'gofmt']
"let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
" au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>r :exe "GoRun %"<CR>
au Filetype go nnoremap <leader>t :exe "GoTest"<CR>
au Filetype go nnoremap <leader>b :exe "GoBuild"<CR>
au Filetype go nnoremap <leader>i :exe "GoInfo"<CR>
au Filetype go nnoremap <leader>d :exe "GoDoc"<CR>

" enable ultisnips but use different selection to not conflict with
" YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-x>"

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
