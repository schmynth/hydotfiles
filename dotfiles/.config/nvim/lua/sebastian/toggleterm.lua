local M = {}

require("toggleterm").setup({
  size = 15,
  open_mapping = [[<C-t>]],  -- Ctrl+t toggles terminal at the bottom
  direction = "horizontal",
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = false,
})

-- Create a persistent terminal instance at the bottom
local Terminal = require("toggleterm.terminal").Terminal


-- This will be your bottom terminal
local bottom_term = Terminal:new({
  direction = "horizontal",
  hidden = true,
  close_on_exit = false,
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-t>", [[<C-\><C-n>:lua require("sebastian.toggleterm").toggle()<CR>]], { noremap = true, silent = true })
  end,
})

function M.toggle()
  bottom_term:toggle()
end

function M.run_build()
  if not bottom_term:is_open() then
    bottom_term:toggle()  -- open it if not already
  end
  bottom_term:send("./buildAndLaunch.sh\n", true)
end

function M.setup_keymaps()
  vim.keymap.set({ "n", "t" }, "<C-t>", M.toggle, { desc = "Toggle bottom terminal" })
  vim.keymap.set("n", "<F5>", M.run_build, { desc = "Run buildAndLaunch.sh in terminal" })
end

return M
