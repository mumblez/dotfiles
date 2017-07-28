let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_working_path_mode = 'c'
" show hidden directory
let g:ctrlp_show_hidden = 1
let g:ctrlp_dotfiles = 1

set wildignore+=*/tmp/*,.DS_Store,*.so,*.swp,*.zip     " MacOSX/Linux

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
