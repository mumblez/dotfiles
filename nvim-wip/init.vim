" Minimal neovim configuration for go, rust, python
"
" deoplete requires neovim, so this will not work with regular vim
"
" prereqs:
" - neovim
" - neovim python3
" - pip install:
"   - pynvim jedi flake8 autopep8 mypy pylint
"
" includes:
" - syntax checking on save (using neomake, go and gometalinter)
" - goimports on save (using vim-go)
" - auto-completion (using deoplete)
"
" ~/.config/nvim/init.vim # symlink from dotfiles repo

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
    set nocompatible
endif

" use pyenv virtualevs for neovim python executables
let g:python_host_prog = expand("~/.pyenv/versions/neovim2/bin/python")
let g:python3_host_prog = expand("~/.pyenv/versions/neovim3/bin/python")

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
" command Tsplit split term://$SHELL
" command Tvsplit vsplit term://$SHELL
" command Ttabedit tabedit term://$SHELL

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


"== change to directory of file on enter (for each buffer)
" helps with tmux so we can open a split and run terraform or such!
" but also breaks navigation for Rg / Ag search results when jumping to
" results
" autocmd BufEnter * silent! lcd %:p:h " or use mapping \j to set

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
autocmd! bufwritepost init.vim source %

"== Script configs =="
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
"=== end of old vimrc  ================

"== return to last edit position when opening files
augroup last_edit
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END

" deoplete
set completeopt=menuone,noinsert,noselect " auto complete setting
" let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_smart_case = 1
"let g:deoplete#auto_complete_start_length = 1
"let g:deoplete#keyword_patterns = {}
"let g:deoplete#keyword_patterns['default'] = '\h\w*'
"let g:deoplete#omni#input_patterns = {}

" deoplete new way to handle options
"[deoplete] g:deoplete#enable_smart_case is deprecated variable.  Please use deoplete#custom#option() instead.

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
let g:ale_set_loclist = 1
" breaks navigating items in qf across multi files
let g:ale_set_quickfix = 0
let g:ale_open_list = 1

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1



" use real tabs in .go files, not spaces
"autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

"== create cache dir, for tags, vim sessions...
let cache_dir = expand('~/.cache')
if !isdirectory(cache_dir)
    silent! execute "!mkdir " . cache_dir
endif

"fix color support
set termguicolors

" plugins
call plug#begin()
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" colour scheme
" Plug 'sainnhe/edge'

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Status line
Plug 'glepnir/galaxyline.nvim'
" Plug 'vim-airline/vim-airline'

" Debugging
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

" Github Integration
Plug 'pwntester/octo.nvim'

" Icons
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'kyazdani42/nvim-tree.lua'

Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/gv.vim'
Plug 'scrooloose/nerdtree'


Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'wincent/terminus'

" Plug 'sheerun/vim-polyglot'
" Plug 'hashivim/vim-terraform'
" Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'ervandew/supertab'

Plug 'w0rp/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'jiangmiao/auto-pairs'
let vim_markdown_preview_github=1
" brew install grip
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 15
" Plug 'majutsushi/tagbar' " toggle with F8 (startup/mappings.vim)
" build and cache tags rather than maintain tags file for each project
" need to also ensure $HOME/.ctags exists with definitions for each language
" using universal ctags, can drop tag definitions in ~/.ctags.d/<lang>.ctags
" but rusty-tags will use from other plugins, e.g.
" ~/.config/nvim/plugged/rust/ctags/rust.ctags
" brew install --HEAD universal-ctags/universal-ctags/universal-ctags # need
" this for recursive support!
" mkdir ~/.cache/gutentags # for vim-gutentags to cache tag files
"Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_cache_dir = cache_dir . '/gutentags'
" override system ctags when xcode installed
" let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
"Plug 'romainl/vim-qf'
" this only works if you manually clone to ~/.config/nvim/plugged
" then add below line. Use 'Ack <search term>', dd irrelevant lines/files,
" then 'Acks /replace/me/' to do multi-file search and replace
Plug 'wincent/ferret'
Plug 'xolox/vim-session'
let vim_sessions_cache_dir = cache_dir . '/vim-sessions'
Plug 'xolox/vim-misc'
"Plug 'tpope/vim-obsession'
" Plug 'ryanoasis/vim-devicons' "icons are small unless using different font
" but then breaks status line and tmux line!
Plug 'szw/vim-maximizer' " F3 to toggle

call plug#end()

"== create plugin cache directories
" for plugin_cache_dir in [g:gutentags_cache_dir, vim_sessions_cache_dir]
for plugin_cache_dir in [vim_sessions_cache_dir]
    silent! execute "!mkdir " . plugin_cache_dir
endfor

" Ultisnips for completion engine
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<m-j>"
" let g:UltiSnipsJumpBackwardTrigger="<m-k>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
"

let g:completion_enable_snippet = 'UltiSnips'

" NEW STUFF
" Fuzzy finder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr> 

" Syntax
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
EOF
" Status line
luafile ~/.config/nvim/eviline.lua
 
 
" END OF NEW STUFF



" install missing plugins on start
autocmd VimEnter *
            \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall
            \| endif


" RUST SETUP
"let g:ale_rust_cargo_use_check = 1
let g:rustfmt_autosave = 1
" if executable('racer')
"   " cargo install racer
"   " rustup component add rust-src
"   let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
"   let g:racer_cmd = systemlist('which racer')[0]
" endif
"
" if executable('rustc')
"     " if src installed via rustup, we can get it by running
"     " rustc --print sysroot then appending the rest of the path
"     let rustc_root = systemlist('rustc --print sysroot')[0]
"     let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'
"     if isdirectory(rustc_src_dir)
"         let g:deoplete#sources#rust#rust_source_path = rustc_src_dir
"     endif
" endif
" let g:racer_experimental_completer = 1
"
" " rust mappings
" augroup rust_bindings
"     au!
"     " au FileType rust nmap gd <Plug>(rust-def)
"     " au FileType rust nmap <leader>gd <Plug>(rust-doc)
"     au FileType rust nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
"     au FileType rust nmap <buffer> K  <plug>DeopleteRustShowDocumentation
"     " au FileType rust nmap <buffer> <leader>t :AsyncRun cargo test<cr> " weird errors
"     au FileType rust nmap <buffer> <leader>t :!cargo test<cr>
"     au FileType rust nmap <buffer> <leader>r :AsyncRun cargo run -q<cr>
"     " au FileType rust nmap <buffer> <leader>r :sp term://cargo run -q<cr>
"     " au FileType rust nmap <buffer> <leader>r :AsyncRun RustRun<cr>
"     au FileType rust nmap <buffer> <leader>b :AsyncRun cargo build<cr>
"     " navigate errors using location list overriding quick fix
"     " autocmd FileType rust command! Lnext try | lnext | catch | lfirst | catch | endtry
"     " autocmd FileType rust command! Lprev try | lprev | catch | llast | catch | endtry
"     " autocmd FileType rust nnoremap <silent> <C-Down> :Lnext<CR>
"     " autocmd FileType rust nnoremap <silent> <C-Up> :Lprev<CR>
" augroup END

"require'nvim_lsp'.terraformls.setup{}
" nvim_lsp.terraformls.setup{
" root_dir = nvim_lsp.util.root_pattern('.terraform');
" }
" require'nvim_lsp'.rust_analyzer.setup{}
" require'nvim_lsp'.gopls.setup{}
" require'nvim_lsp'.pyls.setup{}
" require'nvim_lsp'.bashls.setup{}
" require'nvim_lsp'.yamlls.setup{}
lua <<EOF
local lspconfig = require'lspconfig'
lspconfig.bashls.setup{}
lspconfig.yamlls.setup{}
lspconfig.pyls.setup{}
lspconfig.gopls.setup{}
EOF

" autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
" let g:SuperTabDefaultCompletionType = "<c-n>"
"autocmd BufWrite * :Autoformat

" nnoremap <silent>gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>

" END RUST SETUP
"

" -------------------- LSP ---------------------------------
:lua << EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require('completion').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        require('lspconfig').util.nvim_multiline_command [[
        :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end
  end

  local servers = {'pyright', 'gopls', 'rust_analyzer', 'bashls', 'yamlls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" -------------------- LSP ---------------------------------



"== Load custom settings =="
" for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
"     exe 'source' f
" endfor
source ~/.vim/startup/color.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
"autocmd FileType go source ~/.vim/startup/golang.vim
"source ~/.vim/startup/golang.vim
" source ~/.vim/startup/python.vim
"source ~/.vim/startup/airline.vim
"source ~/.vim/startup/ctrlp.vim
"source ~/.vim/startup/terraform.vim

" set rtp+=~/.fzf

" ctags for go - brew install gotags
" let g:tagbar_type_go = {
"             \ 'ctagstype' : 'go',
"             \ 'kinds'     : [
"             \ 'p:package',
"             \ 'i:imports:1',
"             \ 'c:constants',
"             \ 'v:variables',
"             \ 't:types',
"             \ 'n:interfaces',
"             \ 'w:fields',
"             \ 'e:embedded',
"             \ 'm:methods',
"             \ 'r:constructor',
"             \ 'f:functions'
"             \ ],
"             \ 'sro' : '.',
"             \ 'kind2scope' : {
"             \ 't' : 'ctype',
"             \ 'n' : 'ntype'
"             \ },
"             \ 'scope2kind' : {
"             \ 'ctype' : 't',
"             \ 'ntype' : 'n'
"             \ },
"             \ 'ctagsbin'  : 'gotags',
"             \ 'ctagsargs' : '-sort -silent'
"             \ }


" it'll use ctags from rust.vim instead
" also crashes on mod tests when below def enabled, but also works when not
" enabled!
" workaround is to open vim first (without a file) then open the file within
" vim!
" https://github.com/majutsushi/tagbar/wiki#rust
"  let g:tagbar_type_rust = {
"     \ 'ctagstype' : 'rust',
"     \ 'kinds' : [
"         \'T:types,type definitions',
"         \'f:functions,function definitions',
"         \'g:enum,enumeration names',
"         \'s:structure names',
"         \'m:modules,module names',
"         \'c:consts,static constants',
"         \'t:traits',
"         \'i:impls,trait implementations',
"     \]
"     \}

" let g:tagbar_autoshowtag = 1
" let g:tagbar_autofocus = 1
" let g:tagbar_autoclose = 1
" autocmd FileType go,rust nested :TagbarOpen "annoying on close, have to press, also breaks colouring
" colors - http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" fix highlight and function signature color
" highlight TagbarSignature ctermfg=37
" highlight TagbarHighlight ctermfg=119
" also strange errors when there are tests within a lib.rs

" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)
" xmap <C-k> <Plug>(neosnippet_expand_target)
"
" let g:neosnippet#disable_runtime_snippets = {
"             \ 'go': 1
"             \}

"""" Airline config (cool status bars)..
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#tab_nr_type = 1 " show tab # not splits in tab
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_tabs = 0
" let g:airline#extensions#tabline#show_buffers = 1
" let g:airline#extensions#bufferline#overwrite_variables = 1
" let g:airline#extensions#bufferline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
"
" """" Bufferline (show buffers on airline) config
" let g:bufferline_echo = 1 " no buffer display on the command line
" let g:bufferline_active_buffer_left = '>'
" let g:bufferline_active_buffer_right = '<'
" let g:bufferline_show_bufnr = 1
" " let g:bufferline_active_highlight = 'StatusLineNC'
" let g:bufferline_active_highlight = 'airline_c'
" " let g:bufferline_inactive_highlight = 'airline_c'
"
"let g:polyglot_disabled = ['ansible', 'yaml', 'yml']
let g:ansible_unindent_after_newline = 1
autocmd FileType yml let b:autoformat_autoindent=0
autocmd FileType yml let b:autoformat_retab=0

" set modeline
" set modelines=5

" vimwiki on Dropbox
" let g:vimwiki_list = [{'path': '~/Dropbox/Apps/VimWiki', 'path_html': '~/Dropbox/Apps/VimWiki/public_html'}]
