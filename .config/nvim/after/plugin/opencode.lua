vim.opt.autoread = true

vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
vim.keymap.set({ "n", "v" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
  { desc = "Ask about..." })

vim.keymap.set("n", "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })

vim.keymap.set("n", "<leader>o+", function() return require("opencode").operator("@buffer ") end,
  { desc = "Add file to opencode", expr = true })
vim.keymap.set("v", "<leader>o+", function() return require("opencode").operator("@this ") end,
  { desc = "Add range to opencode", expr = true })

vim.keymap.set({ "n", "v" }, "<leader>oe", function() require("opencode").prompt "Explain @this and its context" end,
  { desc = "Explain this code" })

vim.keymap.set("n", "<leader>on", function() require("opencode").command("session.new") end,
  { desc = "New session" })

vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
  { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
  { desc = "Scroll opencode down" })

vim.keymap.set({ "n", "v" }, "<leader>os", function() require("opencode").select() end,
  { desc = "Select prompt" })
