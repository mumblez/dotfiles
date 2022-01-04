local status_ok, luasnip_snipmate_loader = pcall(require, "luasnip.loaders.from_snipmate")
if not status_ok then
  return
end

-- Load snippets from vim-snippets including custom
-- from ~/.config/nvim/snippets/{ft}.snippets
luasnip_snipmate_loader.load()
