return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  -- root_markers are needed for lsp to work
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
}
