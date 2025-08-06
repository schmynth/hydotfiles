local M = {}

local harpoon = require("harpoon")


-- You can add more groups later like:
-- M.open_utils_ui = function() open_named_ui("utils") end

-- harpoon setup

-- local builtin = require("telescope.builtin")
harpoon:setup()

-- for named UI:
local function open_named_ui(group_name)
  local list = require("harpoon"):list(group_name)


  require("harpoon").ui:toggle_quick_menu(list, {
  title = "📁 Harpoon Group: " .. group_name
  })
end

function M.setup_keymaps()

  -- set keymaps

  -- adding files to Lists
  vim.keymap.set("n", "<leader>ag", function() harpoon:list("global"):add() end)
  vim.keymap.set("n", "<leader>ah", function() harpoon:list("header"):add() end)
  vim.keymap.set("n", "<leader>ai", function() harpoon:list("implementation"):add() end)
  vim.keymap.set("n", "<leader>ad", function() harpoon:list("documentation"):add() end)

  -- general menu
  vim.keymap.set("n", "<leader>hg", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

  -- specific menus

  vim.keymap.set("n", "<leader>h<M-1>", function() harpoon:list("global"):select(1) end)
  vim.keymap.set("n", "<leader>h<M-2>", function() harpoon:list("global"):select(2) end)
  vim.keymap.set("n", "<leader>h<M-3>", function() harpoon:list("global"):select(3) end)
  vim.keymap.set("n", "<leader>h<M-4>", function() harpoon:list("global"):select(4) end)
  vim.keymap.set("n", "<leader>h<M-5>", function() harpoon:list("global"):select(5) end)
  vim.keymap.set("n", "<leader>h<M-6>", function() harpoon:list("global"):select(6) end)
  vim.keymap.set("n", "<leader>hh<M-1>", function() harpoon:list("header"):select(1) end)
  vim.keymap.set("n", "<leader>hh<M-2>", function() harpoon:list("header"):select(2) end)
  vim.keymap.set("n", "<leader>hh<M-3>", function() harpoon:list("header"):select(3) end)
  vim.keymap.set("n", "<leader>hh<M-4>", function() harpoon:list("header"):select(4) end)
  vim.keymap.set("n", "<leader>hh<M-5>", function() harpoon:list("header"):select(5) end)
  vim.keymap.set("n", "<leader>hh<M-6>", function() harpoon:list("header"):select(6) end)
  vim.keymap.set("n", "<leader>hi<M-1>", function() harpoon:list("implementation"):select(1) end)
  vim.keymap.set("n", "<leader>hi<M-2>", function() harpoon:list("implementation"):select(2) end)
  vim.keymap.set("n", "<leader>hi<M-3>", function() harpoon:list("implementation"):select(3) end)
  vim.keymap.set("n", "<leader>hi<M-4>", function() harpoon:list("implementation"):select(4) end)
  vim.keymap.set("n", "<leader>hi<M-5>", function() harpoon:list("implementation"):select(5) end)
  vim.keymap.set("n", "<leader>hi<M-6>", function() harpoon:list("implementation"):select(6) end)
  vim.keymap.set("n", "<leader>hd<M-1>", function() harpoon:list("documentation"):select(1) end)
  vim.keymap.set("n", "<leader>hd<M-2>", function() harpoon:list("documentation"):select(2) end)
  vim.keymap.set("n", "<leader>hd<M-3>", function() harpoon:list("documentation"):select(3) end)
  vim.keymap.set("n", "<leader>hd<M-4>", function() harpoon:list("documentation"):select(4) end)
  vim.keymap.set("n", "<leader>hd<M-5>", function() harpoon:list("documentation"):select(5) end)
  vim.keymap.set("n", "<leader>hd<M-6>", function() harpoon:list("documentation"):select(6) end)
  vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
  vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
  vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
  vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)
  vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end)
  vim.keymap.set("n", "<M-6>", function() harpoon:list():select(6) end)

  vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
  vim.keymap.set("n", "<C-S-P>", function() harpoon:list():next() end)
  vim.keymap.set("n", "<leader>hh", function() open_named_ui() end)
  vim.keymap.set("n", "<leader>hh", function() open_named_ui("header") end)
  vim.keymap.set("n", "<leader>hi", function() open_named_ui("implementation") end)
  vim.keymap.set("n", "<leader>hd", function() open_named_ui("documentation") end)
end


return M
