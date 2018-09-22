" Minimal neovim configuration for go
"
" deoplete requires neovim, so this will not work with regular vim
"
" prereqs:
" - neovim
" - neovim python3 (pip3 install --upgrade neovim)
"
" includes:
" - syntax checking on save (using neomake, go and gometalinter)
" - goimports on save (using vim-go)
" - auto-completion (using deoplete)
"
" Then save this file as ~/.config/nvim/init.vim

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

"== setup plug if not installed
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

let g:mapleader = ","

"set inccommand=split

set noshowmode
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

autocmd BufEnter * if &buftype == "terminal" | startinsert | endif
tnoremap <Esc> <C-\><C-n>
command Tsplit split term://$SHELL
command Tvsplit vsplit term://$SHELL
command Ttabedit tabedit term://$SHELL

set hidden

"=== old vimrc ===
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
"=== end of old vimrc  ================

" deoplete
set completeopt=longest,menuone " auto complete setting
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

" neomake
" autocmd BufWritePost * Neomake
" let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
" let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
" let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
" let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
" let g:neomake_go_gometalinter_maker = {
"   \ 'args': [
"   \   '--tests',
"   \   '--enable-gc',
"   \   '--concurrency=3',
"   \   '--fast',
"   \   '-D', 'aligncheck',
"   \   '-D', 'dupl',
"   \   '-D', 'gocyclo',
"   \   '-D', 'gotype',
"   \   '-E', 'errcheck',
"   \   '-E', 'misspell',
"   \   '-E', 'unused',
"   \   '%:p:h',
"   \ ],
"   \ 'append_file': 0,
"   \ 'errorformat':
"   \   '%E%f:%l:%c:%trror: %m,' .
"   \   '%W%f:%l:%c:%tarning: %m,' .
"   \   '%E%f:%l::%trror: %m,' .
"   \   '%W%f:%l::%tarning: %m'
"   \ }

" ale
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1


" vim-go
let g:go_def_mapping_enabled = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_term_enabled = 1

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
let g:go_snippet_engine = "neosnippet"

" use real tabs in .go files, not spaces
"autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" plugins
call plug#begin()

"==Plug 'neomake/neomake'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'sebdah/vim-delve'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/vim/symlink.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Needed to make sebdah/vim-delve work on Vim
Plug 'Shougo/vimshell.vim'                  " Needed to make sebdah/vim-delve work on Vim
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neocomplcache'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
"Plug 'mhinz/vim-signify'
Plug 'jodosha/vim-godebug'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'LnL7/vim-nix'
Plug 'cespare/vim-toml'
Plug 'edkolev/tmuxline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'bling/vim-bufferline'
Plug 'mattn/emmet-vim'
Plug 'pearofducks/ansible-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-packer'
Plug 'godlygeek/tabular'
Plug 'wincent/terminus'
Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'
"Plug 'racer-rust/vim-racer'
Plug 'w0rp/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'jiangmiao/auto-pairs'
let vim_markdown_preview_github=1
" brew install grip
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 15
"Plug 'wokalski/autocomplete-flow'
Plug 'elmcast/elm-vim'
Plug 'pbogut/deoplete-elm'
" brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" mkdir ~/.cache
Plug 'majutsushi/tagbar' " toggle with F8 (startup/mappings.vim)
" build and cache tags rather than maintain tags file for each project
" need to also ensure $HOME/.ctags exists with definitions for each language
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '~/.cache/gutentags'

call plug#end()

" tell gutentags how to detect root of a project to build tags for
autocmd FileType rust let g:gutentags_project_root = ['Cargo.toml']
autocmd FileType rust call add(g:gutentags_project_info, {'type': 'rust', 'file': 'Cargo.toml'})


" brew install delve
" xcode-select --install for dlv / lldb-server to work

let g:delve_backend = "native"


" install missing plugins on start
autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif

call deoplete#custom#source('_', 'converters',
      \ ['converter_auto_paren',
      \  'converter_auto_delimiter',
      \  'converter_remove_overlap'])

" mappings

" deoplete
imap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <cr>    pumvisible() ? deoplete#close_popup() : "\<cr>"

" vim-go mappings
autocmd FileType go nmap <buffer> <leader>r <plug>(go-run)
autocmd FileType go nmap <buffer> <leader>b <plug>(go-build)
autocmd FileType go nmap <buffer> <leader>t <plug>(go-test)
autocmd FileType go nmap <buffer> <leader>e <plug>(go-rename)
autocmd FileType go nmap <buffer> <leader>d <plug>(go-doc)
"autocmd FileType go nmap <buffer> gd <plug>(go-def-vertical)
autocmd FileType go nmap <buffer> gd <plug>(go-def)
autocmd FileType go nmap <buffer> <c-]> <plug>(go-def)
autocmd FileType go nmap <buffer> <leader>i <plug>(go-info)
"au FileType go nmap <buffer> <C-t> <Plug>(go-def-pop)
"
" rust
let g:rustfmt_autosave = 1
if executable('racer')
  " cargo install racer
  " rustup component add rust-src
  let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
  let g:racer_cmd = systemlist('which racer')[0]
endif

if executable('rustc')
    " if src installed via rustup, we can get it by running 
    " rustc --print sysroot then appending the rest of the path
    let rustc_root = systemlist('rustc --print sysroot')[0]
    let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'
    if isdirectory(rustc_src_dir)
        let g:deoplete#sources#rust#rust_source_path = rustc_src_dir
    endif
endif
let g:racer_experimental_completer = 1

" rust mappings
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType rust nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
au FileType rust nmap <buffer> K  <plug>DeopleteRustShowDocumentation
au FileType rust nmap <buffer> <leader>t :AsyncRun cargo test<cr>
au FileType rust nmap <buffer> <leader>r :AsyncRun cargo run<cr>
" au FileType rust nmap <buffer> <leader>r :AsyncRun RustRun<cr>
au FileType rust nmap <buffer> <leader>b :AsyncRun cargo build<cr>

"== Load custom settings =="
source ~/.vim/startup/color.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
"autocmd FileType go source ~/.vim/startup/golang.vim
"source ~/.vim/startup/golang.vim
source ~/.vim/startup/python.vim
"source ~/.vim/startup/airline.vim
source ~/.vim/startup/ctrlp.vim
source ~/.vim/startup/terraform.vim

set rtp+=~/.fzf

" ctags for go - brew install gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
    \ }



" add to $HOME/.ctags -
" https://github.com/nikomatsakis/rust-ctags/blob/master/ctags.rust, more
" reliable method definitions than putting definition with tagbar
" cargo install rusty-tags
" let g:tagbar_type_rust = {
"     \ 'ctagstype': 'rust',
"     \ 'kinds': [
"         \ 's:structs',
"         \ 'i:impls, trait implementations',
"         \ 't:traits',
"         \ 'F:methods',
"         \ 'c:consts, static constants',
"         \ 'f:functions',
"         \ 'g:enums',
"         \ 'T:types, type defs',
"         \ 'v:variables',
"         \ 'M:macros',
"         \ 'm:fields',
"         \ 'e:variants'
"     \ ]}

"\ 'ctagsargs' : '-sort -silent'
"\ 'ctagsbin'  : 'rusty-tags'}
let g:tagbar_autoshowtag = 1
autocmd FileType go,rust nested :TagbarOpen
" colors - http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" fix highlight and function signature color 
highlight TagbarSignature ctermfg=37
highlight TagbarHighlight ctermfg=119

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

let g:neosnippet#disable_runtime_snippets = {
    \ 'go': 1
    \}

"""" Airline config (cool status bars)
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab # not splits in tab
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"""" Bufferline (show buffers on airline) config
let g:bufferline_echo = 1 " no buffer display on the command line
let g:bufferline_active_buffer_left = '>'
let g:bufferline_active_buffer_right = '<'
let g:bufferline_show_bufnr = 1
" let g:bufferline_active_highlight = 'StatusLineNC'
let g:bufferline_active_highlight = 'airline_c'
" let g:bufferline_inactive_highlight = 'airline_c'

