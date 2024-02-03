vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<S-F2>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<C-S-F5>", ":lua require'dap'.restart()<CR>")
vim.keymap.set("n", "<F6>", ":lua require'dap'.pause()<CR>")
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_back()<CR>")
vim.keymap.set("n", "<space>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<space>lb", ":lua require'dap'.list_breakpoints()<CR>")
vim.keymap.set("n", "<space>cb", ":lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set("n", "<space>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<space>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<space>dt", ":lua require'dap-go'.debug_test()<CR>")

local dap, dapui = require("dap"), require("dapui")
require("dapui").setup()

require("dap-go").setup {
  dap_configurations = {
    {
      type = "go",
      name = "Attach remote / Headless",
      mode = "remote",
      request = "attach",
    },
  },
  delve = {
    path = "dlv",
    initialize_timeout_sec = 20,
    port = "38697",
    args = {},
    build_flags = "",
  },
}

require("nvim-dap-virtual-text").setup {
  enabled = true,

  -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
  enabled_commands = false,

  -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_changed_variables = true,
  highlight_new_as_changed = true,

  -- prefix virtual text with comment string
  commented = false,

  show_stop_reason = true,

  -- experimental features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
}

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode',
  name = 'lldb'
}

dap.configurations.c = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {}
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  daqui.close()
end
