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

"== treat words with '-' as whole words
" set iskeyword-=-

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

" completion
set completeopt=menuone,noinsert,noselect " auto complete setting
set shortmess+=c

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

" Terraform
Plug 'hashivim/vim-terraform'
let g:terraform_allign = 1
let g:terraform_fmt_on_save = 1

" colour scheme
" Plug 'sainnhe/edge'
Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'rktjmp/lush.nvim'


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Status and buffer line
Plug 'glepnir/galaxyline.nvim'
Plug 'ap/vim-buftabline'
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
Plug 'hashivim/vim-terraform'
Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
" Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" Plug 'glepnir/lspsaga.nvim'
" patch for neovim nightly
Plug 'rinx/lspsaga.nvim'
" Plug 'ervandew/supertab'

" Plug 'w0rp/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'jiangmiao/auto-pairs'
let vim_markdown_preview_github=1
" brew install grip
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 15
Plug 'wincent/ferret'
Plug 'xolox/vim-session'
let vim_sessions_cache_dir = cache_dir . '/vim-sessions'
Plug 'xolox/vim-misc'
Plug 'szw/vim-maximizer' " F3 to toggle
Plug 'ray-x/lsp_signature.nvim'

call plug#end()

" install missing plugins on start
autocmd VimEnter *
            \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall
            \| endif

"== create plugin cache directories
" for plugin_cache_dir in [g:gutentags_cache_dir, vim_sessions_cache_dir]
for plugin_cache_dir in [vim_sessions_cache_dir]
    silent! execute "!mkdir " . plugin_cache_dir
endfor

" Ultisnips for completion engine
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<m-j>"
let g:UltiSnipsJumpBackwardTrigger="<m-k>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
"

" Fuzzy finder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr> 
nnoremap <leader>fa <cmd>Telescope grep_string<cr> 

" Syntax
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  ident = {
      enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  ensure_installed = {
      "bash",
      "dockerfile",
      "go",
      "gomod",
      "lua",
      "python",
      "rust",
      "toml",
      "vim"
  }
}
EOF

" Status line
luafile ~/.config/nvim/eviline.lua

" Buflinetab
let g:buftabline_show = 1

" RUST SETUP
let g:rustfmt_autosave = 1



" -------------------- LSP ---------------------------------
lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })
EOF

lua <<EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require('lsp_signature').on_attach({
        bind = true,
        handler_opts = {
            border = "single"
        }
    }, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    -- maybe cleanup - https://github.com/stnley/.dotfiles/blob/main/nvim/.config/nvim/lua/stnley/config/lsp/init.lua#L111
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
            augroup lsp_document_highlight
                autocmd!
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
  end

  local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local servers = {'pyright', 'gopls', 'bashls', 'rust_analyzer'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_init = custom_init,
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end

 nvim_lsp['terraformls'].setup{
   settings = {
    experimentalFeatures = {
     prefillRequiredFields = true,
     validateOnSave = true,
    },
   },
   on_init = custom_init,
   on_attach = function(client)
       client.resolved_capabilities.document_formatting = false
       client.resolved_capabilities.document_range_formatting = false
       on_attach(client)
   end,
   capabilities = capabilities,
 }
EOF


" autoformat
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000) 
" autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync(nil, 1000) 
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000) 
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000) 
 
lua <<EOF
  local saga = require'lspsaga'
  saga.init_lsp_saga()
EOF
nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> ga <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> ga :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> rn :Lspsaga rename<CR>


" Enable type inlay hints
" autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
set signcolumn=yes


 
" -------------------- LSP ---------------------------------

"== Load custom settings =="
source ~/.config/nvim/startup/functions.vim
source ~/.config/nvim/startup/mappings.vim

set rtp+=~/.fzf

colorscheme darcula-solid

let g:ansible_unindent_after_newline = 1
autocmd FileType yml let b:autoformat_autoindent=0
autocmd FileType yml let b:autoformat_retab=0

