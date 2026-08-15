require('snacks').setup {
  input = { -- Enhances opencode `ask()`
    enabled = true
  },
  picker = { -- Enhances opencode `select()`
    actions = {
      opencode_send = function(...) return require("opencode").snacks_picker_send(...) end
    },
    win = {
      input = {
        keys = {
          ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
        },
      },
    },
  }
}
