-- vim.cmd [[
-- try
--   " colorscheme darkplus
--   colorscheme darcula-solid
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]


-- local colorscheme = "darcula-solid"
local colorscheme = "nightfox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
end

local nf = require('nightfox')
nf.setup({
  fox = "nightfox",
  styles = {
    comments = "italic", -- change style of comments to be italic
    keywords = "bold", -- change style of keywords to be bold
    functions = "italic,bold" -- styles can be a comma separated list
  },
  inverse = {
    match_paren = true, -- inverse the highlighting of match_parens
  },
  colors = {
    red = "#FF000", -- Override the red color for MAX POWER
    bg_alt = "#000000",
  },
  hlgroups = {
    TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
    LspCodeLens = { bg = "#000000", style = "italic" },
  }
})
nf.load()

-- show column boundary when we get there
-- vim.cmd [[
--     highlight ColorColumn ctermbg=magenta
--     call matchadd('ColorColumn', '\%81v', 100)
-- ]]
