vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _makefile
    autocmd!
    autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  "rust inlay hints from lsp_extensions"
  augroup _rust
    autocmd!
    autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
  augroup end

 augroup _terraform
   autocmd!
   autocmd BufWritePre *.tf :lua vim.lsp.buf.format()
 augroup end

]]

--  augroup _terraform
--    autocmd!
--    autocmd BufWritePre *.tf :lua vim.lsp.buf.format()
--  augroup end
-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
